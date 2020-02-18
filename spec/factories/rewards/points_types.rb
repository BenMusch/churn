FactoryBot.define do
  factory :rewards_points_type, class: 'Rewards::PointsType' do
    name { "MyString" }
    institution { nil }
  end
end
