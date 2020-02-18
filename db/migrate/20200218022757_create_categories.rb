class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent_category, null: true, foreign_key: { to_table: :categories }
      t.string :plaid_id

      t.timestamps
    end
  end
end
