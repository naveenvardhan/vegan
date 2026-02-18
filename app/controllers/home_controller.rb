class HomeController < ApplicationController
  before_action :set_cart
  before_action :authenticate_customer!, except: [:index]
  before_action :set_customer, except: [:index]

  def index
    if params[:query].present?
      @items = Item.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @items = Item.all
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
