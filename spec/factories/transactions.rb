FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { "MyString" }
  end
end
