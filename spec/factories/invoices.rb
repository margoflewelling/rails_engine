FactoryBot.define do
  factory :invoice do
    customer_id { 1 }
    merchant_id { 1 }
    status { "Shipped" }
    created_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
    updated_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
  end
end
