class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :vendor, foreign_key: true
      t.references :farmer, foreign_key: true
      t.integer :address_id
      t.integer :warehouse_id
      t.integer :outlet_id
      t.integer :delivery_boy_id
      t.string :invoice_number
      t.decimal :sub_total
      t.decimal :gst
      t.decimal :delivery_charge
      t.decimal :discount
      t.decimal :total_amount
      t.string :status
      t.string :delivery_type
      t.datetime :order_date

      t.timestamps
    end
  end
end
