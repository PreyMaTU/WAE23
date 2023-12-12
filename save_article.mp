
has 'title' => (required => 1);
has 'lva_number' => (required => 1);
has 'module' => (required => 1);
has 'content' => (required => 1);
has 'old_lva_number';

method handle() {
  # Only allow editing when logged in
  if( !defined $m->session->{user_id} ) {
    $m->redirect('/wae08/index');
    return;
  }

  # Lookup the module id by its url_name
  my $dbh = Ws23::DBI->dbh();
  my $module_sth = $dbh->prepare("SELECT id FROM group08_modules WHERE url_name = ?");
  $module_sth->execute( $.module);
  my $module = $module_sth->fetchrow_hashref;
  if( !defined $module ) {
    $m->redirect('/wae08/not_found?kind=module&id=' . $.module);
    return;
  }

  # Do not allow duplicate lva numbers
  my $check_sth = $dbh->prepare("SELECT COUNT(*) AS count FROM group08_article WHERE lva_number = ? OR lva_number = ?");
  $check_sth->execute($.lva_number, $.old_lva_number);

  my $max_allowed_count= defined $.old_lva_number ? 2 : 1;
  if( $check_sth->fetchrow_hashref->{count} >= $max_allowed_count ) {
    $m->redirect( defined $.old_lva_number ? '/wae08/editor?article=' . $.old_lva_number : '/wae08/editor' );
    return;
  }

  # Update or insert article
  my $dbh = Ws23::DBI->dbh();
  if( !defined $.old_lva_number ) {
    my $article_sth = $dbh->prepare(
      "INSERT INTO group08_article (title, lva_number, module, content, author, edit_data)
        VALUES (?, ?, ?, ?, ?, NOW())"
    );
    $article_sth->execute( $.title, $.lva_number, $module->{id}, $.content, $m->session->{user_id} );
  } else {
    my $article_sth = $dbh->prepare(
      "UPDATE group08_article SET title= ?, lva_number= ?, module= ?, content= ?, author= ?, edit_data= NOW()
        WHERE lva_number= ?"
    );
    $article_sth->execute( $.title, $.lva_number, $module->{id}, $.content, $m->session->{user_id}, $.old_lva_number );
  }

  $m->redirect("/wae08/editor?article=" . $.lva_number);
}
