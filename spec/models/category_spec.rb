require "rails_helper"

RSpec.describe Category, type: :model do
  let(:root) { create(:category, name: "All purchases") }
  let(:food) { create(:category, name: "Food", parent_category: root) }
  let(:fast_food) { create(:category, name: "Fast food", parent_category: food) }
  let(:fast_casual) { create(:category, name: "Fast casual", parent_category: fast_food) }
  let(:groceries) { create(:category, name: "Groceries", parent_category: food) }
  let(:entertainment) { create(:category, name: "Entertainment", parent_category: root) }

  describe "validations" do
    it "cannot have the name 'All purchases' unless it's the root" do
      expect(build(:category, name: "All purchases")).to be_valid
      expect(build(:category, name: "All purchases", parent_category: build(:category, name: "All purchases")))
        .not_to be_valid
    end

    it "must have a parent if its name is not 'All purchases'" do
      expect(build(:category, name: "Food")).not_to be_valid
      expect(build(:category, name: "Food", parent_category: build(:category, name: "All purchases")))
        .to be_valid
    end
  end

  describe "contains?" do
    it "returns true if the passed category is self or any of its children" do
      # root: first layer
      expect(root.contains?(root)).to be true
      expect(root.contains?(food)).to be true
      expect(root.contains?(fast_food)).to be true
      expect(root.contains?(fast_casual)).to be true
      expect(root.contains?(groceries)).to be true
      expect(root.contains?(entertainment)).to be true

      # second layer
      expect(food.contains?(root)).to be false
      expect(food.contains?(food)).to be true
      expect(food.contains?(fast_food)).to be true
      expect(food.contains?(fast_casual)).to be true
      expect(food.contains?(groceries)).to be true
      expect(food.contains?(entertainment)).to be false

      expect(entertainment.contains?(root)).to be false
      expect(entertainment.contains?(food)).to be false
      expect(entertainment.contains?(fast_food)).to be false
      expect(entertainment.contains?(fast_casual)).to be false
      expect(entertainment.contains?(groceries)).to be false
      expect(entertainment.contains?(entertainment)).to be true

      # third layer
      expect(fast_food.contains?(root)).to be false
      expect(fast_food.contains?(food)).to be false
      expect(fast_food.contains?(fast_food)).to be true
      expect(fast_food.contains?(fast_casual)).to be true
      expect(fast_food.contains?(groceries)).to be false
      expect(fast_food.contains?(entertainment)).to be false

      expect(groceries.contains?(root)).to be false
      expect(groceries.contains?(food)).to be false
      expect(groceries.contains?(fast_food)).to be false
      expect(groceries.contains?(fast_casual)).to be false
      expect(groceries.contains?(groceries)).to be true
      expect(groceries.contains?(entertainment)).to be false

      # fourth layer
      expect(fast_casual.contains?(root)).to be false
      expect(fast_casual.contains?(food)).to be false
      expect(fast_casual.contains?(fast_food)).to be false
      expect(fast_casual.contains?(fast_casual)).to be true
      expect(fast_casual.contains?(groceries)).to be false
      expect(fast_casual.contains?(entertainment)).to be false
    end
  end
end
