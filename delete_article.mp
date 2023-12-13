
has 'lva_number' => (required => 1);
has 'module' => (required => 1);

method handle() {
  # Only allow deleting when logged in
  if( !defined $m->session->{user_id} ) {
    $m->redirect('/wae08/index');
    return;
  }

  my $dbh = Ws23::DBI->dbh();
  my $module_sth = $dbh->prepare("DELETE FROM group08_article WHERE lva_number = ?");
  $module_sth->execute( $.lva_number );

  $m->redirect("/wae08/module/" . $.module);
}
