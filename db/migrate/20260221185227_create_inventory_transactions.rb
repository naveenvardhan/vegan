class CreateInventoryTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_transactions do |t|
      t.references :order_item, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :cost_price

      t.timestamps
    end
  end
end
