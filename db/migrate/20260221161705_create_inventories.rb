class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :item, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :cost_price
      t.date :stock_date
      t.decimal :remaining_quantity

      t.timestamps
    end
  end
end
