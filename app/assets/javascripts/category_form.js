$(document).on("turbolinks:load",function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div id='child-wrap'>
                        <select id="child_category" name="item[category_id]">
                          <option value="---" data-category="---">---</option>
                          ${insertHTML}
                        </select>
                      </div>`;
    $('#form-group-first').append(childSelectHtml);
  }
  // // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div id='grandchild_wrap'>
                              <select id="grandchild_category" name="item[category_id]">
                                <option value="---" data-category="---">---</option>
                                ${insertHTML}
                              </select>
                            </div>`;
    $('#form-group-first').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#item_category_id').on('change', function(){
    var parentCategory = document.getElementById('item_category_id').value; //選択された親カテゴリーの値(id)を取得
    if (parentCategory.length != 0){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child-wrap').remove(); //親が変更された時、子以下を削除する
        $('#grandchild_wrap').remove();
        // $('#size_wrapper').remove();      もしサイズを選べるようにするなら追記
        // $('#brand_wrapper').remove();     もしブランドを選べるようにするなら追記
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child-wrap').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchild_wrap').remove();
    //   $('#size_wrapper').remove();   もしサイズを選べるようにするなら追記
    //   $('#brand_wrapper').remove();  もしブランドを選べるようにするなら追記
    }
  });
  // 子カテゴリー選択後のイベント
  $('.form-group-first').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_wrap').remove(); //子が変更された時、孫以下を削除するする
  //         $('#size_wrapper').remove();    もしサイズを選べるようにするなら追記
  //         $('#brand_wrapper').remove();   もしブランドを選べるようにするなら追記
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_wrap').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      // $('#size_wrapper').remove();    もしサイズを選べるようにするなら追記
      // $('#brand_wrapper').remove();   もしブランドを選べるようにするなら追記
    }
  });
});