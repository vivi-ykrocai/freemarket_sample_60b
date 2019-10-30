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
    item_salse_status       {2}
    good                    {5}
    category_id             {3}
    created_at              {Faker::Time.between(5.days.ago, 3.days.ago, :all)}
    seller_id               {1}
    buyer_id                {2}
  end

end





