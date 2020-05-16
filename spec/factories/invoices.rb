FactoryBot.define do
  factory :invoice do
    customer_id { 1 }
    merchant_id { 1 }
    status { "MyString" }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
