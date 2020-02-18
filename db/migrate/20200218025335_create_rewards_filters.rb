class CreateRewardsFilters < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_filters do |t|
      t.string :vendor_filter

      t.timestamps
    end
  end
end
