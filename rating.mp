
has 'rating';
has 'comment';
has 'article_id';
has 'lva_number';

method handle() {
  # Only logged in users can add ratings
  if( !defined $m->session->{user_id} ) {
    $m->redirect("/wae08/index");
    return;
  }

  # Update or insert rating
  my $dbh = Ws23::DBI->dbh();
  my $rating_sth = $dbh->prepare(
    "INSERT INTO group08_rating (user, value, comment, article, edit_date)
      VALUES (?, ?, ?, ?, NOW())
      ON DUPLICATE KEY UPDATE
        value = VALUES(value),
        comment = VALUES(comment),
        edit_date = VALUES(edit_date)"
  );
  $rating_sth->execute( $m->session->{user_id}, $.rating, $.comment, $.article_id );

  $m->redirect("/wae08/article/". $.lva_number);
}
