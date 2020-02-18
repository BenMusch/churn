class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
