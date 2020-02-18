class CreateRewardsPercentages < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_percentages do |t|
      t.references :card, null: false, foreign_key: true
      t.integer :percent
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
