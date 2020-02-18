FactoryBot.define do
  factory :rewards_percentage, class: 'Rewards::Percentage' do
    card { nil }
    percent { 1 }
    category { nil }
  end
end
