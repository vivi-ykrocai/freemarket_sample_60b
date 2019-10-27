FactoryBot.define do
  factory :user, class: User  do
    id                       {10}
    nick_name                {Faker::Pokemon.name}
    email                   {Faker::Internet.email}
    password                {"test123"}
    encrypted_password      {"test123"}
    family_name              {"test"}
    last_name               {"test"}
    family_name_kana         {"テスト"}
    last_name_kana          {"テスト"}
    birthday                {"2019-10-5"}
    phone_number             {Faker::Lorem.characters(11)}
    postal_code              {"1620041"}
    prefectures              {"東京都"}
    city                     {"新宿区"}
    address                  {"東町22-1"}
    created_at              {"2019-10-19 07:27:19"}
    updated_at              {"2019-10-19 07:27:19"}
  end

  factory :another_user, class: User do
    id                       {20}
    nick_name                {Faker::Pokemon.name}
    email                   {Faker::Internet.email}
    password                {"test321"}
    encrypted_password      {"test321"}
    family_name              {"test"}
    last_name               {"test"}
    family_name_kana         {"テストテスト"}
    last_name_kana          {"テストテスト"}
    birthday                {"2019-10-20"}
    phone_number             {Faker::Lorem.characters(11)}
    postal_code              {"1620042"}
    prefectures              {"神奈川県"}
    city                     {"横浜市"}
    address                  {"西町1-22"}
    created_at              {"2019-10-20 07:27:19"}
    updated_at              {"2019-10-20 07:27:19"}
  end
end


