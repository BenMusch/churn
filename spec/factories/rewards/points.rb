FactoryBot.define do
  factory :rewards_point, class: "Rewards::Point" do
    card { nil }
    points_per_dollar { 1.5 }
    association :rewards_filter, factory: :rewards_filter
    association :rewards_points_type, factory: :rewards_points_type
  end
end
