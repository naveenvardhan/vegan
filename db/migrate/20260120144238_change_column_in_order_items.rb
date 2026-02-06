class ChangeColumnInOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_column :order_items, :quantity, :decimal
  end
end
