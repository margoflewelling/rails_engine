FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Commerce.price }
    merchant_id { Faker::Number.between(from: 1, to: 10)}
    created_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
    updated_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
  end
end
