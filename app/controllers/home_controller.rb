class HomeController < ApplicationController
  before_action :set_cart
  before_action :authenticate_customer!, except: [:index]
  before_action :set_customer, except: [:index]
  
  def index
    if params[:seller] == 'true' || current_customer&.business_type == 'Seller'
      @items = Item.for_seller
    else
      @items = Item.for_hotel
    end

    if params[:grade].present?
      @items = @items.where(grade: params[:grade])
    else
      @items = @items.where(grade: 'A')
    end

    if params[:query].present?
      @items = @items.where("name ILIKE ?", "%#{params[:query]}%")
    end
    @items = @items.order(:priority)
    @items = @items.group_by(&:sub_category).transform_values { |items| items.sort_by { |i| i.priority || 9999 } }
    if current_customer.present?
      @last_order = current_customer.orders.includes(order_items: :item).order(created_at: :desc).first
      # @last_order = Order.find 38
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def profile
    @orders    = @customer.orders.order(created_at: :desc)
    @addresses = @customer.addresses
  end

  def edit_profile
  end

  def update_profile
    if @customer.update(customer_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Failed to update profile."
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(
      :name,
      :phone,
      :gender,
      :business_name,
      :email
    )
  end
end
