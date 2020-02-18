class AddVendorFilterToRewardsPercentages < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards_percentages, :vendor_filter, :string, default: ".*"
  end
end
