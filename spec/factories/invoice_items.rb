FactoryBot.define do
  factory :invoice_item do
    item_id { Faker::Number.between(from: 1, to: 100) }
    invoice_id { 1 }
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Commerce.price }
  end
end
