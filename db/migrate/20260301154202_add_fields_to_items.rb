class AddFieldsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :grade, :string, default: 'A'
    add_column :items, :sub_category, :string
    add_column :items, :show_for_seller, :boolean, default: true
    add_column :items, :show_for_hotel, :boolean, default: true
  end
end
