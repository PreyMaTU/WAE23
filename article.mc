<%class>
  route "{lva_number:[a-zA-Z0-9]{3}\.[a-zA-Z0-9]{3}}";
</%class>

<%init>
  my $dbh = Ws23::DBI->dbh();
  my $article_sth = $dbh->prepare("SELECT a.*, u.name 
                                  FROM group08_article as a 
                                  JOIN group08_user as u ON a.author = u.id 
                                  WHERE lva_number = ?");
  $article_sth->execute( $.lva_number );

  my $article = $article_sth->fetchrow_hashref;
  if( !$article ) {
    $m->redirect('/wae08/index');
  }

  my $dbh = Ws23::DBI->dbh();
  my $rating_sth = $dbh->prepare("SELECT r.*, u.name 
                                  FROM group08_rating as r 
                                  JOIN group08_article as a ON r.article = a.id 
                                  JOIN group08_user as u ON u.id = r.user
                                  WHERE lva_number = ?");
  $rating_sth->execute( $.lva_number );
</%init>

<section class="header">
  <div class="title">
    <h2><% $article->{title} %></h2>
% if( defined $m->session->{user_id} ) {
    <a class="button" href="/editor.html?article=<% $article->{lva_number} %>" title="Edit this article">✏️ Edit</a> 
% } else {
    <a class="button disabled" title="Sign in to edit this article">✏️ Edit</a>
% }

  </div>
  <div class="buttons">
    <div class="info">
      <span class="button" title="LVA-Nr. <% $article->{lva_number} %>">📕 <% $article->{lva_number} %></span>
      <a class="button" href="" title="Module <% $article->{title} %>">
        🗄️ <% $article->{title} %>
      </a>
      <span class="button colored-by-rating" title="Rating 3.8"> ⭐ 3.8 </span>
      <span class="button" title="<% $article->{views} %> views"> 👓 <% $article->{views} %> </span>
    </div>
    <div>
      Last edited
      <span class="date" title="<% $article->{edit_data} %>"><% $article->{edit_data} %></span>
      by
      <span class="author"><% $article->{name} %></span>
    </div>
  </div>
</section>
<section class="article">
  <article class="article-text adjust-headers">  
    <% $article->{content} %>
  </article>
</section>
<section class="new-review">
  <form action="." method="POST">
    <div>
      <label for="new-rating">Rating</label>
      <div class="slider">
        <input type="range" min="0" max="5" step="0.1" value="5" required name="rating" id="new-rating">
        <span id="new-rating-value" class="colored-by-rating">5.0</span>
      </div>
    </div>
    <div>
      <label for="new-comment">Comment</label>
      <textarea name="comment" id="new-comment" cols="30" rows="10" placeholder="Add your thoughts..."></textarea>
    </div>
    <button type="submit">Save</button>
  </form>
</section>
<section class="reviews"> 
  <ul>
% while( my $rating = $rating_sth->fetchrow_hashref ) {
  <& article_rating_item.mi, author => $rating->{name}, 
                            edit_date => $rating->{edit_date},
                            rating => $rating->{value},
                            comment => $rating->{comment}&>
% }
  </ul>
</section>
