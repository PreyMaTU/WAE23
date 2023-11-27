
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

document.querySelectorAll('.article-index span.rating').forEach( elem => {
  const ratingValue = parseFloat(elem.innerText);
  const hue = ratingValue * 20; // map 0-5 to 0-100
  elem.style.backgroundColor = `hsl(${hue}deg 92% 72%)`;
});



