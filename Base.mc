<%class>
has 'title' => (default => 'LVA-Review');
</%class>

<%augment wrap>
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/wae08/static/css/main.css">
    <script type="module" src="/wae08/static/js/main.js" defer></script>
    % $.Defer {{
      <title><% $.title %></title>
    % }}
  </head>
  <body>
    <& header.mi &>
    <div class="page">
      <main>
        <% inner() %>
      </main>
      <aside>
        <& news.mi &>
      </aside>
    </div>
    <& footer.mi &>
  </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>
