<%class>
  has 'id' => (default => 'electives');
</%class>

<%init>
  my $dbh = Ws23::DBI->dbh();
  my $sth = $dbh->prepare("SELECT * FROM group08_modules where url_name = ?");
  $sth->execute( $.id );

  my $module = $sth->fetchrow_hashref;
  if( !$module ) {
    $m->redirect('/wae08/index');
  }

</%init>

<section class="article-index">
  <div class="title">
    <h2><% $module->{name} %></h2>
% if( defined $m->session->{user_id} ) {
    <a class="button" href="/editor.html?module=<% $.id %>" title="Create new Article">➕ Create</a> 
% } else {
    <a class="button disabled" title="Sign in to create a new article">➕ Create</a>
% }
  </div>
  <ul>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
    <& module_article_item.mi, title => 'Algorithmen und Datenstrukturen', lva_number => '182.345', rating => 3.5 &>
  </ul>
</section>
