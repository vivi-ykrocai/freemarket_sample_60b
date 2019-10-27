$(document).on("turbolinks:load",function(){
  $(".hidden-form").hide();
  // 配送料の負担選択後のイベント
  $('#item_delivery_charged').on('change', function(){
    var itemDeliveryCharged = document.getElementById('item_delivery_charged').value;
    // 選択結果によってセレクトボックスを表示・非表示
    if (itemDeliveryCharged == "送料込み（出品者負担）"){
      $(".cash-on-delivery").show();
      $(".payment-on-delivery").hide();
      $(".delete-default").remove();
    }else if (itemDeliveryCharged == "着払い（購入者負担）"){
      $(".cash-on-delivery").hide();
      $(".payment-on-delivery").show();
      $(".delete-default").remove();
    }else{
      $(".cash-on-delivery").hide();
      $(".payment-on-delivery").hide();
    }
  });
  // 送料込み・着払いそれぞれの情報をhidden_formへ渡す
  $("#cash-on-delivery").on('change', function(){
    var itemDeliveryMethod = document.getElementById('cash-on-delivery').value;
    $("#item_delivery_method_decision").val(itemDeliveryMethod)
  });
  $("#payment-on-delivery").on('change', function(){
    var itemDeliveryMethod = document.getElementById('payment-on-delivery').value;
    $("#item_delivery_method_decision").val(itemDeliveryMethod)
  });
});
