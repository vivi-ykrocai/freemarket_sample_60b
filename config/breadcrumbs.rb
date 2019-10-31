crumb :root do
  link "メルカリ", root_path
end

crumb :category do
  link 'カテゴリー一覧', categories_path
  parent :root
end

crumb :category_show_parents do
  @category = Category.find(params[:id])
  link  "#{@category.name}", root_path
  parent :category
end

crumb :mypage do
  link 'マイページ', user_path(current_user)
  parent :root
end

crumb :mypage_listing do
  link '出品した商品-出品中',selling_user_path(current_user)
  parent :mypage
end

crumb :mypage_progression do
  link '出品した商品-取引中', progression_user_path(current_user)
  parent :mypage
end

crumb :mypage_transcation do
  link '取引画面', transcation_item_path
  parent :mypage_progression
end

crumb :mypage_completion do
  link '出品した商品-売却済', completion_user_path(current_user)
  parent :mypage
end

crumb :mypage_purchase do
  link '購入した商品-取引中', purchase_user_path(current_user)
  parent :mypage
end

crumb :mypage_purchased do
  link '購入した商品-過去の取引', purchased_user_path(current_user)
  parent :mypage
end

crumb :mypage_profile do
  link 'プロフィール', profile_user_path(current_user)
  parent :mypage
end

crumb :mypage_credit_card do
  link '支払い方法',  card_user_path(current_user)
  parent :mypage
end

crumb :mypage_identification do
  link '本人情報', identification_user_path(current_user)
  parent :mypage
end

crumb :mypage_logout do
  link 'ログアウト',  logout_user_path(current_user)
  parent :mypage
end

crumb :mypage_listing_item do
  link '出品商品画面', detail_item_path
  parent :mypage_listing
end







