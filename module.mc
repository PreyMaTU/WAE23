<%class>
  route "{id:[a-z_]*}";
</%class>

<%init>
  my $dbh = Ws23::DBI->dbh();
  my $sth = $dbh->prepare("SELECT * FROM group08_article as a JOIN group08_modules as m ON a.module = m.id WHERE m.url_name = ?");
  $sth->execute( $.id );

  my $rowdata = $sth->fetchrow_hashref;
  if( !$rowdata ) {
    $m->redirect('/wae08/index');
  }
</%init>

<section class="article-index">
  <div class="title">
    <h2><% $rowdata->{name} %></h2>
% if( defined $m->session->{user_id} ) {
    <a class="button" href="/editor.html?module=<% $.id %>" title="Create new Article">➕ Create</a> 
% } else {
    <a class="button disabled" title="Sign in to create a new article">➕ Create</a>
% }
  </div>
  <ul>
    <& module_article_item.mi, title => $rowdata->{title}, lva_number => $rowdata->{lva_number}, rating => 3.5 &>
% while( my $rowdata = $sth->fetchrow_hashref ) {
    <& module_article_item.mi, title => $rowdata->{title}, lva_number => $rowdata->{lva_number}, rating => 3.5 &>
% }
  </ul>
</section>
