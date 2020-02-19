FactoryBot.define do
  factory :card do
    name { "MyString" }
    institution { association(:institution) }
  end
end
