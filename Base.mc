<%class>
has 'title' => (default => 'LVA-Review');
has 'username';
has 'password';
</%class>

<%augment wrap>
  <%perl>
    if( $.username && $.password ) {
      # Clear the old session
      undef( $m->session->{user_id} );

      # Get id, hashed pwd and salt for user name
      my $dbh = Ws23::DBI->dbh();
      my $sth = $dbh->prepare("SELECT id, password_hash, password_salt FROM group08_user WHERE name=?");
      $sth->execute( $.username );
      my $user = $sth->fetchrow_hashref;

      # Hash the provided pwd with the salt and check if it matches
      if( defined $user->{id} ) {
        my $password_hash = crypt($.password, $user->{password_salt});
        if( $password_hash eq $user->{password_hash} ) {
          $m->session->{user_id} = $user->{id}
        }
      }

      # No user id was set -> login failure
      if( !defined $m->session->{user_id} ) {
        $m->redirect('/wae08/index?bad_credentials')
      }
    }

  </%perl>

  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/wae08/static/css/main.css">
    <script type="module" src="/wae08/static/js/main.js" defer></script>
    <script src="/static/js/ckeditor/ckeditor.js"></script>
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
