require "rails_helper"

RSpec.describe ValueCalculator do
  let(:root) { create(:category, name: "All purchases") }
  let(:food) { create(:category, name: "Food", parent_category: root) }
  let(:fast_food) { create(:category, name: "Fast food", parent_category: food) }
  let(:fast_casual) { create(:category, name: "Fast casual", parent_category: fast_food) }
  let(:groceries) { create(:category, name: "Groceries", parent_category: food) }
  let(:entertainment) { create(:category, name: "Entertainment", parent_category: root) }

  let(:all_purchases_filter) { create(:rewards_filter, categories: [root]) }
  let(:food_filter) { create(:rewards_filter, categories: [food]) }
  let(:groceries_filter) { create(:rewards_filter, categories: [groceries]) }
  let(:simple_cashback_card) { create(:card) }
  let(:dining_card) { create(:card) }

  let(:cash_back_points) { create(:rewards_points_type, name: "Cash back") }
  let(:cash_back_payout) do
    create(:rewards_points_payout,
           rewards_filter: all_purchases_filter,
           rewards_points_type: cash_back_points,
           dollars_per_point: 0.01)
  end
  let(:two_percent_on_everything) do
    create(:rewards_point,
           card: simple_cashback_card,
           points_per_dollar: 2,
           rewards_points_type: cash_back_points,
           rewards_filter: all_purchases_filter)
  end
  let(:one_percent_on_everything) do
    create(:rewards_point,
           card: dining_card,
           points_per_dollar: 1,
           rewards_points_type: cash_back_points,
           rewards_filter: all_purchases_filter)
  end
  let(:three_percent_on_food) do
    create(:rewards_point,
           card: dining_card,
           points_per_dollar: 3,
           rewards_points_type: cash_back_points,
           rewards_filter: food_filter)
  end
  let(:four_percent_on_groceries) do
    create(:rewards_point,
           card: dining_card,
           rewards_points_type: cash_back_points,
           points_per_dollar: 4,
           rewards_filter: groceries_filter)
  end

  before do
    # create the points since they were lazily-created in lets
    one_percent_on_everything
    two_percent_on_everything
    three_percent_on_food
    four_percent_on_groceries
    cash_back_payout
  end

  describe "#value_in_dollars" do
    it "calculates correctly with cash back points in one category" do
      expect(ValueCalculator.value_of(build(:transaction, category: root, amount: 10), simple_cashback_card))
        .to eq 0.2
      expect(ValueCalculator.value_of(build(:transaction, category: food, amount: 10), simple_cashback_card))
        .to eq 0.2
      expect(ValueCalculator.value_of(build(:transaction, category: fast_food, amount: 10), simple_cashback_card))
        .to eq 0.2
      expect(ValueCalculator.value_of(build(:transaction, category: fast_casual, amount: 10), simple_cashback_card))
        .to eq 0.2
      expect(ValueCalculator.value_of(build(:transaction, category: groceries, amount: 10), simple_cashback_card))
        .to eq 0.2
      expect(ValueCalculator.value_of(build(:transaction, category: entertainment, amount: 10), simple_cashback_card))
        .to eq 0.2
    end

    it "calculates correct with cash back points in multiple categories" do
      expect(ValueCalculator.value_of(build(:transaction, category: root, amount: 10), dining_card))
        .to eq 0.1
      expect(ValueCalculator.value_of(build(:transaction, category: food, amount: 10), dining_card))
        .to eq 0.3
      expect(ValueCalculator.value_of(build(:transaction, category: fast_food, amount: 10), dining_card))
        .to eq 0.3
      expect(ValueCalculator.value_of(build(:transaction, category: fast_casual, amount: 10), dining_card))
        .to eq 0.3
      expect(ValueCalculator.value_of(build(:transaction, category: groceries, amount: 10), dining_card))
        .to eq 0.4
      expect(ValueCalculator.value_of(build(:transaction, category: entertainment, amount: 10), dining_card))
        .to eq 0.1
    end
  end
end
