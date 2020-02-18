FactoryBot.define do
  factory :category do
    name { "MyString" }
    parent_category { nil }
    plaid_id { "MyString" }
  end
end
