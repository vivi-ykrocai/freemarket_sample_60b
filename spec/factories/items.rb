FactoryBot.define do
  factory :item do
    name                    {Faker::Team.name}
    item_status             {1}
    delivery_charged        {1}
    delivery_method         {1}
    delivery_area           {'東京都'}
    delivery_shipping_date  {3}
    total_price             {1000}
    item_profile_comment    {Faker::Lorem.sentence}
    category_id             {2}
    seller_id               {1}
  end
end





