FactoryBot.define do
  factory :user do
    nick_name              { "shima" }
    email                 { "kkk@gmail.com" }
    password              { "00000000" }
    password_confirmation { "00000000" }
    family_name           { "茜" }
    last_name             { "色蓮" }
    family_name_kana      { "アカネ" }
    last_name_kana        { "イロハス" }
    birthday              { "2019-01-02" }
    postal_code           { "1234567" }
    prefectures           { "東京都" }
    city                  { "日野市" } 
    address               { "カーサリンベル" }
    phone_number          { "00000000000" }
    phone_number2         { "00000000000" }
  end
  factory :other_user, class: User do
    nick_name { "Ito Taro" }
    email { "ito@rails.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    family_name            { "伊藤" }
    last_name             { "太郎" }
    family_name_kana      { "イトウ" }
    last_name_kana        { "タロウ" }
    birthday              { "2019-10-25" }
    postal_code           { "9000003" }
    prefectures           { "沖縄" }
    city                  { "那覇市" } 
    address               { "安謝14-3-6" }
    phone_number          { "08012345678" }
    phone_number2         { "08012345678" }
    admin { 'false' }
  end
end