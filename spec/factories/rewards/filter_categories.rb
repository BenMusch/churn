FactoryBot.define do
  factory :rewards_filter_category, class: "Rewards::FilterCategory" do
    association rewards_filter
    association category
  end
end
