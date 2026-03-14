class AddSellerDescToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :seller_remarks, :string
  end
end
