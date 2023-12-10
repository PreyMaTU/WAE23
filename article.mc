<%class>
  route "{lva_number:[a-zA-Z0-9]{3}\.[a-zA-Z0-9]{3}}";
</%class>

<%init>
  # Get the article, author and module info
  my $dbh = Ws23::DBI->dbh();
  my $article_sth = $dbh->prepare("SELECT a.*, u.name, m.name as module_name, m.url_name as module_url_name 
                                  FROM group08_article as a 
                                  JOIN group08_user as u ON a.author = u.id 
                                  JOIN group08_modules as m ON a.module = m.id 
                                  WHERE lva_number = ?");
  $article_sth->execute( $.lva_number );

  my $article = $article_sth->fetchrow_hashref;
  if( !$article ) {
    $m->redirect('/wae08/index');
  }

  # Get all the ratings
  my $rating_sth = $dbh->prepare("SELECT r.*, u.name 
                                  FROM group08_rating as r 
                                  JOIN group08_user as u ON u.id = r.user
                                  WHERE r.article = ?");
  $rating_sth->execute( $article->{id} );

  # Load all ratings and compute average rating value
  my @ratings_array;
  my $avg_rating_value= 0;
  while( my $rating = $rating_sth->fetchrow_hashref ) {
    push( @ratings_array, $rating );
    $avg_rating_value += $rating->{value};
  }

  # Print the avg value with a single decimal place
  if( scalar( @ratings_array ) ) { 
    $avg_rating_value= sprintf('%.1f', $avg_rating_value / scalar( @ratings_array ) );
  } else {
    $avg_rating_value= 'NA';
  }

  # Update the view count only once per session
  my $sessionKey= 'viewed_' . $article->{id};
  if( !defined $m->session->{$sessionKey} ) {
    $m->session->{$sessionKey}= 1;
    my $view_count_update_sth = $dbh->prepare("UPDATE group08_article SET views = views+1 WHERE id = ?");
    $view_count_update_sth->execute( $article->{id} );
  }
  
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
      <a class="button" href="/wae08/module/<% $article->{module_url_name} %>" title="Module <% $article->{module_name} %>">
        🗄️ <% $article->{module_name} %>
      </a>
      <span class="button colored-by-rating" title="Rating <% $avg_rating_value %>"> ⭐ <% $avg_rating_value %> </span>
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
% foreach my $rating ( @ratings_array ) {
  <& article_rating_item.mi, author => $rating->{name}, 
                            edit_date => $rating->{edit_date},
                            rating => $rating->{value},
                            comment => $rating->{comment}&>
% }
  </ul>
</section>
