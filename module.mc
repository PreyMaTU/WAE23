<%class>
  has 'id' => (required => 1);
</%class>

<section class="article-index">
  <div class="title">
    <h2>Algorithms</h2>
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
