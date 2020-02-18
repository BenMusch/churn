class CreateRewardsPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_points do |t|
      t.references :card, null: false, foreign_key: true
      t.float :points_per_dollar
      t.references :rewards_filter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
