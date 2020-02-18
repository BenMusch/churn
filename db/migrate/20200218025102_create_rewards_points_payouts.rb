class CreateRewardsPointsPayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_points_payouts do |t|
      t.integer :dollars_per_point
      t.references :rewards_points_type, null: false, foreign_key: true
      t.references :rewards_filter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
