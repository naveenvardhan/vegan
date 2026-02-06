class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :customer, foreign_key: true, null: true
      t.string :session_id, index: true
      t.string :status
      t.timestamps
    end
  end
end
