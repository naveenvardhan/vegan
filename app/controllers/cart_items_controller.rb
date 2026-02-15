class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(item_id: @item.id)
    
    # Handle increment/decrement from params, default to 1
    if params[:adjustment] == "plus"
      @cart_item.quantity += 1
    elsif params[:adjustment] == "minus"
      @cart_item.quantity -= 1
    else
      @cart_item.quantity = 1
    end

    if @cart_item.quantity <= 0
      @cart_item.destroy
    else
      @cart_item.save
    end

    respond_to do |format|
      format.turbo_stream # For instant UI updates
      format.html { redirect_back fallback_location: root_path }
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          # Update the +/- buttons
          turbo_stream.replace("item_#{@item.id}_cart_control", partial: "home/item", locals: { item: @item }),
          
          turbo_stream.replace("item_#{@item.id}_cart_control_mobile", partial: "home/item", locals: { item: @item }),
          # Update the line total for this specific item in the cart table
          turbo_stream.update("item_#{@item.id}_line_total", "(₹#{@cart_item.quantity * @item.price})"),
          # Update the grand total in the sidebar
          turbo_stream.update("cart_grand_total", "₹#{@cart.total_price}"),
          # Update the sidebar items total
          turbo_stream.update("cart_items_total", "₹#{@cart.total_price}"),
          # Update the navbar badge
          turbo_stream.update("cart_count", @cart.cart_items.count)
        ]
      end
    end
  end

  private

end