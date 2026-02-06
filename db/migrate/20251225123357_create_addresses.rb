class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, null: false
      t.string :line_1
      t.string :line_2
      t.string :area
      t.string :landmark
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :is_default

      t.timestamps
    end
  end
end
