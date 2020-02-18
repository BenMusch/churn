class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :plaid_id
      t.string :name

      t.timestamps
    end
  end
end
