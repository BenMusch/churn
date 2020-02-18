FactoryBot.define do
  factory :rewards_points_payout, class: "Rewards::PointsPayout" do
    dollars_per_point { 1 }
    points_type { nil }
    category { nil }
    rewards_filter { nil }
  end
end
