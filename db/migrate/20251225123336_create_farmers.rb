class CreateFarmers < ActiveRecord::Migration[7.0]
  def change
    create_table :farmers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
