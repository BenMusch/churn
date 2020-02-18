FactoryBot.define do
  factory :rewards_filter, class: 'Rewards::Filter' do
    vendor_filter { "MyString" }
  end
end
