class CreateLinkedAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :linked_accounts do |t|
      t.references :institution, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :plaid_id
      t.string :plaid_type
      t.string :plaid_subtype
      t.string :mask

      t.timestamps
    end
  end
end
