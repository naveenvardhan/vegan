class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.decimal :mrp
      t.decimal :price
      t.string :quantity
      t.string :unit
      t.text :description

      t.timestamps
    end
  end
end
