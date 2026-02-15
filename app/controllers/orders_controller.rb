class OrdersController < ApplicationController
  before_action :set_cart

  # def new
  #   @order = Order.new
  #   if @cart.cart_items.empty?
  #     redirect_to root_path, alert: "Your cart is empty!"
  #   end
  # end
  
  def new
    # Case 1: Not logged in
    # debugger
    if current_customer.nil?
      # Store the intended destination so we can return after signup
      session[:return_to] = new_order_path
      redirect_to new_customer_registration_path, alert: "Please sign up to complete your order."
      return
    end

    # Case 2: Logged in but has no addresses
    if current_customer.addresses.empty?
      redirect_to new_address_path(redirect_to_checkout: true), notice: "Please add a delivery address to continue."
      return
    end

    # Case 3: Logged in and has address (Success)
    @order = Order.new
    @addresses = current_customer.addresses
    @cart_items = @cart.cart_items
  end

  def create
    # binding.pry
    @order = Order.new(order_params)
    @order.customer = current_customer if current_customer
    @order.status = "pending"
    @order.total_amount = @cart.total_price
    @order.order_date = Time.current

    if @order.save
      # Move items from Cart to Order
      @cart.cart_items.each do |ci|
        @order.order_items.create!(
          item_id: ci.item_id,
          quantity: ci.quantity,
          price_at_order: ci.item.price
        )
      end
      @order.update_total
      
      # Clear the cart
      @cart.cart_items.destroy_all
      session[:cart_token] = nil # Optional: reset guest session
      
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find params[:id]
    # @order = Order.includes(order_items: :street_post, :package, :payment).find_by(id: params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address_id, :delivery_type, :notes, :payment_type)
  end
end