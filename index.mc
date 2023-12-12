<%init>
  # Load the 3 top viewed articles per module and also compute their average rating if possible
  my $dbh = Ws23::DBI->dbh();
  my $sth = $dbh->prepare(
    "WITH top_articles_per_module AS (
      SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (PARTITION BY module ORDER BY views DESC) AS n FROM group08_article
      ) AS top WHERE n <= 3
    )
    SELECT m.name as module_name, art.*
    FROM group08_modules as m
    JOIN
      (SELECT a.title, a.lva_number, a.module, LEFT(a.content, 600) as content, AVG(r.value) AS rating
      FROM top_articles_per_module as a
      LEFT OUTER JOIN group08_rating as r ON a.id = r.article
      GROUP BY a.id) as art
    ON m.id = art.module
    ORDER BY m.name ASC"
  );
  $sth->execute();

  # Group the flat array of modules into a 2D array by module name
  my @modules;
  my @current_module;
  while(my $row = $sth->fetchrow_hashref) {
      if (@current_module && $row->{'module_name'} ne $current_module[0]->{'module_name'}) {
          push @modules, [@current_module];
          @current_module = ();
      }
      push @current_module, $row;
  }

  push @modules, [@current_module] if @current_module;
</%init>

% foreach my $module ( @modules ) {


<section class="module">
  <div class="title">
    <h2><% @$module[0]->{module_name} %></h2>
  </div>
  <ol>
% foreach my $article ( @$module ) {
    <& index_article_box.mi, article => $article &>
% }
  </ol>
</section>

% }
