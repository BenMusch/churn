require "rails_helper"

def build_transaction(category, name)
  Transaction.new(account_id: "foo",
                  amount: 100,
                  category: category,
                  date: Time.zone.today,
                  name: name,
                  payment_channel: "special",
                  transaction_type: "special")
end

RSpec.describe Rewards::Filter, type: :model do
  let(:root) { create(:category, name: "All purchases") }
  let(:food) { create(:category, name: "Food", parent_category: root) }
  let(:fast_food) { create(:category, name: "Fast food", parent_category: food) }
  let(:fast_casual) { create(:category, name: "Fast casual", parent_category: fast_food) }
  let(:groceries) { create(:category, name: "Groceries", parent_category: food) }
  let(:entertainment) { create(:category, name: "Entertainment", parent_category: root) }

  describe "validations" do
    describe "vendor_filter" do
      it "rejects invalid regexes" do
        expect(build(:rewards_filter, vendor_filter: "(")).not_to be_valid
        expect(build(:rewards_filter, vendor_filter: ")")).not_to be_valid
        expect(build(:rewards_filter, vendor_filter: "(a|b)\\s+\\"))
          .not_to be_valid
      end

      it "allows valid regexes" do
        expect(build(:rewards_filter, vendor_filter: "()")).to be_valid
        expect(build(:rewards_filter, vendor_filter: "(a|b)[t]")).to be_valid
      end
    end
  end

  describe "include?" do
    context "when it matches none of the categories but does match the vendor filter" do
      it "returns false" do
        transaction = build_transaction(entertainment, "Uber")
        filter = build(:rewards_filter,
                       vendor_filter: ".*Uber.*",
                       categories: [fast_casual, fast_food])
        expect(filter).not_to be_include(transaction)
      end
    end

    context "when it matches one of the categories but not the vendor filter" do
      it "returns false" do
        transaction = build_transaction(entertainment, "Lyft")
        filter = build(:rewards_filter,
                       vendor_filter: ".*Uber.*",
                       categories: [entertainment, fast_food])
        expect(filter).not_to be_include(transaction)
      end
    end

    context "when it matches the vendor filter and a category" do
      it "returns true" do
        transaction = build_transaction(entertainment, "Uber")
        filter = build(:rewards_filter,
                       vendor_filter: ".*Uber.*",
                       categories: [entertainment, fast_food])
        expect(filter).to be_include(transaction)
      end
    end
  end
end
