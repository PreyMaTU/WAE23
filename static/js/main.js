
document.getElementById('profile-button').addEventListener('click', event => {
  let imgElement= event.target;
  while( imgElement && !(imgElement instanceof HTMLImageElement) ) {
    imgElement= imgElement.firstElementChild;
  }

  if( imgElement.src.indexOf('user') >= 0 ) {
    // Show logout dialog
    document.getElementById('logout-dialog').showModal();
  } else {
    // Show login dialog
    document.getElementById('login-dialog').showModal();
  }
});
