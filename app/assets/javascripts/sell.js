function update_field(){
  var fee = Math.floor($('#input-price').val() / 10);
  var profit = $('#input-price').val() - fee;
  if($('#input-price').val() >= 300 ){
    $('#output-fee').text('¥' + fee);
    $('#output-profit').text('¥' + profit);
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