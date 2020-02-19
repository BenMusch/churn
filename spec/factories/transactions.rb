FactoryBot.define do
  factory :transaction do
    account_id { "foo" }
    amount { 100 }
    category { build(:category) }
    date { Time.zone.today }
    name { "Lyft Payment" }
    payment_channel { "foo" }
    transaction_type { "special" }
    iso_currency_code { "USD" }
    payment_meta { {} }
    pending { false }

    initialize_with { new(**attributes) }
  end
end
