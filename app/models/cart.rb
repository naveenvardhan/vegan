class Cart < ApplicationRecord
  # A cart contains many individual line items
  has_many :cart_items, dependent: :destroy
  # Optional: allows you to see which products are in the cart directly
  has_many :items, through: :cart_items
  belongs_to :customer, optional: true

  def total_price(customer = nil)
    cart_items.sum { |ci| ci.item.get_price(customer&.is_seller?) * ci.quantity }
  end

  def total_quantity
    cart_items.sum(:quantity)
  end
  
  # Clear the cart
  def clear_cart!
    self.cart_items.destroy_all
  end
end