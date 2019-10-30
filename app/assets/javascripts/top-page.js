$(document).on("turbolinks:load", function(){
  $('.genre__wrapper__list').click(function(){
    var i = $(".genre__wrapper__list").index(this)
    var p = $(".items__genre__title__text").eq(i).offset().top;
    $('html,body').animate({ scrollTop: p }, 'swing');
    return false;
  });
});