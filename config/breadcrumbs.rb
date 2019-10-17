# 一旦全てroot_pathで指定する。
# あとで必要があれば個別のリンク先を指定する。工藤 10月17日(木)

crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link 'マイページ', root_path
  parent :root
end

crumb :mypage_logout do
  link 'ログアウト', root_path
  parent :mypage
end

crumb :mypage_listing do
  link '出品した商品-出品中', root_path
  parent :mypage
end

crumb :mypage_progression do
  link '出品した商品-取引中', root_path
  parent :mypage
end

crumb :mypage_completion do
  link '出品した商品-売却済', root_path
  parent :mypage
end

crumb :mypage_purchase do
  link '購入した商品-取引中', root_path
  parent :mypage
end

crumb :mypage_purchased do
  link '出品した商品-過去の取引', proot_path
  parent :mypage
end

crumb :mypage_profile do
  link 'プロフィール', root_path
  parent :mypage
end

crumb :mypage_credit_card do
  link '支払い方法', root_path
  parent :mypage
end

crumb :mypage_identification do
  link '本人情報', root_path
  parent :mypage
end
