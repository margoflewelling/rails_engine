FactoryBot.define do
  factory :invoice_item do
    item_id { 1 }
    invoice_id { 1 }
    quantity { 1 }
    unit_price { 1.5 }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
