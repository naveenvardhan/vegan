class AddSellerPriceToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :seller_price, :decimal
  end
end
