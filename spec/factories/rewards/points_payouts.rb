FactoryBot.define do
  factory :rewards_points_payout, class: "Rewards::PointsPayout" do
    dollars_per_point { 1 }
    rewards_filter { nil }
    association :rewards_points_type, factory: :rewards_points_type
  end
end
