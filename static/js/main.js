
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

function makeRatingHslColor( ratingValue ) {
  const hue = ratingValue * 20; // map 0-5 to 0-100
  return `hsl(${hue}deg 92% 72%)`;
}

document.querySelectorAll('.colored-by-rating').forEach( elem => {
  // Try to find a fractional number in the element text content
  const matches= elem.innerText.match(/\d+\.\d+/);
  if( !matches ) {
    return;
  }

  // Convert the text to a number and create a nice color
  const ratingValue = parseFloat( matches[0] );
  elem.style.backgroundColor = makeRatingHslColor( ratingValue );
});

document.querySelectorAll('#new-rating').forEach( elem =>
  elem.addEventListener('input', e => {
    const span= document.getElementById('new-rating-value');
    const value= parseFloat(e.target.value);
    span.innerText = Math.floor(value) !== value ? value : `${value}.0`;
    span.style.backgroundColor = makeRatingHslColor(value);
  })
);

if( CKEDITOR && document.getElementById('lva-article') ) {
  CKEDITOR.replace('lva-article', {});
}
