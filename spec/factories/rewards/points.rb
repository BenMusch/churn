FactoryBot.define do
  factory :rewards_point, class: 'Rewards::Point' do
    card { nil }
    points_per_dollar { 1.5 }
    rewards_filter { nil }
  end
end
