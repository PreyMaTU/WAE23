
method handle() {
  undef( $m->session->{user_id} );
  $m->redirect("/wae08/index");
}
