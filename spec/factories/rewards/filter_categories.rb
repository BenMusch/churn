FactoryBot.define do
  factory :rewards_filter_category, class: 'Rewards::FilterCategory' do
    rewards_filter { nil }
    category { nil }
  end
end
