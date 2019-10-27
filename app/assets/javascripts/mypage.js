$(document).on("turbolinks:load",function(){
  $(".buyed_item_empty").hide();
  $(".buyed_item").hide();
  // 取引中
  $('#during_item-link').on('click', function(){
    $(".during_item").show();
    $(".buyed_item").hide();
    $(".during_item-status").addClass("active");
    $(".buyed_item-status").removeClass("active");
  });
  // 過去の取引
  $('#buyed_item-link').on('click', function(){
    $(".during_item").hide();
    $(".buyed_item").show();
    $(".during_item-status").removeClass("active");
    $(".buyed_item-status").addClass("active");
  });
});
