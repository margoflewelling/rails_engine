FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { "success" }
    created_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
    updated_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
  end
end
