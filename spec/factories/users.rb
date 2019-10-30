FactoryBot.define do
  factory :user, class: User  do
    nick_name               {Faker::Pokemon.name}
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
end


