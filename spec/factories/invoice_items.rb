FactoryBot.define do
  factory :invoice_item do
    item_id { Faker::Number.between(from: 1, to: 100) }
    invoice_id { 1 }
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Commerce.price }
    created_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
    updated_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
  end
end
