class CreateRewardsPercentages < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_percentages do |t|
      t.references :card, null: false, foreign_key: true
      t.references :rewards_filter, null: false, foreign_key: true
      t.integer :percent

      t.timestamps
    end
  end
end
