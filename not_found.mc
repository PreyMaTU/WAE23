<%class>
  has 'kind' => (default => 'item');
  has 'id' => (default => 'unknown');
</%class>

<%init>
  $.title('Not found');
</%init>

<section class="about">
  <h2>Could not find <% $.kind %></h2>
  <article class="article-text">  
    <p>
      The item with the id <% $.id %> could not be found.
    </p>
    <p>
      Go <a href="/wae08">back.</a>
    </p>
  </article>
</section>
