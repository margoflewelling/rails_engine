FactoryBot.define do
  factory :customer do
    id { 1 }
    first_name { "MyString" }
    last_name { "MyString" }
    created_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
    updated_at {Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)}
  end
end
