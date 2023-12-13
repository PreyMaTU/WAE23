<%class>
  has 'module';
  has 'article';
</%class>

<%init>

  # Only allow editing when logged in
  if( !defined $m->session->{user_id} ) {
    $m->redirect('/wae08/index');
    return;
  }

  # Load all known module names
  my $dbh = Ws23::DBI->dbh();
  my $module_sth = $dbh->prepare("SELECT name, url_name FROM group08_modules");
  $module_sth->execute();  

  my $title= '';
  my $lva_number= '';
  my $module= '';
  my $content= '';

  # Try to load exisiting article if an id is provided
  if( $.article ) {
    my $dbh = Ws23::DBI->dbh();
    my $article_sth = $dbh->prepare(
      "SELECT a.*, m.url_name as module_url_name 
      FROM group08_article as a
      JOIN group08_modules as m ON a.module = m.id
      WHERE lva_number = ?");
    $article_sth->execute( $.article );

    my $article = $article_sth->fetchrow_hashref;
    if( !defined $article ) {
      $m->redirect("/wae08/not_found?kind=article&id=" . $.article);
      return;
    }
    
    $title= $article->{title};
    $lva_number= $article->{lva_number};
    $module= $article->{module_url_name};
    $content= $article->{content};
  
  } elsif( $.module ) {
    $module= $.module;
  }

</%init>

<section class="editor">
  <div class="title">
% if( $.article ) {
    <h2>Edit "<% $title %>"</h2>
    <a class="button" href="/wae08/article/<% $.article %>" title="View this article">👓 View</a>
% } else {
    <h2>Create new article</h2>
    <a class="button disabled" title="Save this article to view it">👓 View</a>
% }
  </div>
  <form action="/wae08/save_article" method="POST">
% if( $.article ) {
    <input type="text" name="old_lva_number" value="<% $.article %>" hidden>
% }
    <fieldset>
      <div>
        <label for="lva-number">LVA-Number</label>
        <input type="text" id="lva-number" name="lva_number" placeholder="Number of the LVA" required maxlength="7" pattern="\w{3}\.\w{3}" value="<% $lva_number %>">
      </div>
      <div>
        <label for="lva-title">Title</label>
        <input type="text" id="lva-title" name="title" placeholder="Name of the LVA" required maxlength="100" value="<% $title %>">
      </div>
      <div>
        <label for="lva-module">Module</label>
        <select id="lva-module" name="module">
% while( my $module_item = $module_sth->fetchrow_hashref ) {
          <option value="<% $module_item->{url_name} %>" <% $module_item->{url_name} eq $module ? 'selected' : '' %> >
            <% $module_item->{name} %>
          </option>
% }
        </select>
      </div>
    </fieldset>
    <fieldset>
      <label for="lva-article"></label>
      <textarea name="content" id="lva-article" cols="30" rows="10"><% $content %></textarea>
    </fieldset>
    <div class="submits">
% if( $.article ) {
      <button type="submit" form="delete-form">🗑️ Delete</button>
% } else {
      <button type="submit" disabled>🗑️ Delete</button>
% }
      <button type="submit">💾 Save</button>
    </div>
  </form>
  <form id="delete-form" action="/wae08/delete_article">
    <input type="text" name="lva_number" value="<% $.article %>" hidden>
    <input type="text" name="module" value="<% $module %>" hidden>
  </form>
</section>
