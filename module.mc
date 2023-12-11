<%class>
  route "{id:[a-z_]*}";
</%class>

<%init>
  my $dbh = Ws23::DBI->dbh();
  my $module_sth = $dbh->prepare("SELECT name, id FROM group08_modules WHERE url_name = ?");
  $module_sth->execute( $.id );

  my $module = $module_sth->fetchrow_hashref;
  if( !$module ) {
    my $id= $.id;
    $m->redirect("/wae08/not_found?kind=module&id=$id");
  }

  my $article_sth = $dbh->prepare(
    "SELECT a.*, AVG(r.value) AS average_rating
    FROM group08_article as a
    LEFT OUTER JOIN group08_rating as r ON a.id = r.article
    WHERE a.module = ?
    GROUP BY a.id"
  );
  $article_sth->execute( $module->{id} );

  # Set the name of the module as the page title
  $.title( $module->{name} );
</%init>

<section class="article-index">
  <div class="title">
    <h2><% $module->{name} %></h2>
% if( defined $m->session->{user_id} ) {
    <a class="button" href="/editor.html?module=<% $module->{id} %>" title="Create new Article">➕ Create</a> 
% } else {
    <a class="button disabled" title="Sign in to create a new article">➕ Create</a>
% }
  </div>
  <ul>
% while( my $article = $article_sth->fetchrow_hashref ) {
    <& module_article_item.mi, title => $article->{title}, lva_number => $article->{lva_number}, rating => $article->{average_rating} &>
% }
  </ul>
</section>
