document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('category-list')){
    const categoryList = document.getElementById('category-list')
    const pullDown = document.getElementById('pull-down')

    categoryList.addEventListener('click', function(){
      if (pullDown.getAttribute('style') == 'display: block;') {
        pullDown.removeAttribute('style', 'display: block;')
      } else {
        pullDown.setAttribute('style', 'display: block;')
      }
    });
  }
});