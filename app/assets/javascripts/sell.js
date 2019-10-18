function update_field(){
  var fee = Math.floor($('#input-price').val() / 10);
  var putFee = String(fee).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,' );
  var profit = $('#input-price').val() - fee;
  var putProfit = String(profit).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,' );
  if($('#input-price').val() >= 300 && $('#input-price').val() <= 9999999){
    $('#output-fee').text('¥' + putFee);
    $('#output-profit').text('¥' + putProfit);
  }else{
    $('#output-fee').text('-');
    $('#output-profit').text('-');
  }
}
$(function() {
  $('input[type="number"]').on('keyup change', function() {
    update_field();
  });
});