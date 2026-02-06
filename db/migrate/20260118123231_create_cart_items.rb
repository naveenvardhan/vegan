class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.timestamps
    end

    add_column :customers, :business_name, :string
    add_column :customers, :business_type, :string
    add_column :customers, :aadhar_number, :string
    add_column :customers, :is_kyc_verified, :boolean
  end
end
