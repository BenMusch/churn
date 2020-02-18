FactoryBot.define do
  factory :category do
    name { "All purchases" }
    parent_category { nil }
    plaid_id { SecureRandom.uuid }
  end
end
