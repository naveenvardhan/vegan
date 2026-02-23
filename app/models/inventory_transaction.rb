class InventoryTransaction < ApplicationRecord
  belongs_to :order_item
  belongs_to :inventory
end
