class CreateRewardsFilterCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards_filter_categories do |t|
      t.references :rewards_filter, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
