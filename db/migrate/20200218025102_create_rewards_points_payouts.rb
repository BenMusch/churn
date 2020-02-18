class CreateRewardsPointsPayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_points_payouts do |t|
      t.integer :dollars_per_point
      t.references :points_type, null: false, foreign_key: true
      t.string :vendor_filter
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
