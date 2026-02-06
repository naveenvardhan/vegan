class CartsController < ApplicationController
  before_action :set_cart

  def show
    # @cart is usually set in a before_action in ApplicationController
    # We use .includes(:item) to avoid N+1 queries
    @cart_items = @cart.cart_items.includes(:item).order(:created_at)
  end
end