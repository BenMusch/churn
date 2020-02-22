FactoryBot.define do
  factory :linked_account do
    institution { nil }
    user_id { nil }
    name { "MyString" }
    plaid_id { "MyString" }
    plaid_type { "MyString" }
    plaid_subtype { "MyString" }
    mask { "MyString" }
  end
end
