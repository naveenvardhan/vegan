# app/controllers/addresses_controller.rb
class AddressesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @address = current_customer.addresses.build
    @redirect_to_checkout = params[:redirect_to_checkout]
  end

  def create
    @address = current_customer.addresses.build(address_params)

    if @address.save
      current_customer.update_default_address(@address.id) if @address.is_default
      if params[:redirect_to_checkout] == "true"
        redirect_to new_order_path, notice: "Address added successfully"
      else
        redirect_to root_path, notice: "Address added successfully"
      end
    else
      @redirect_to_checkout = params[:redirect_to_checkout]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :line_1,
      :line_2,
      :area,
      :landmark,
      :city,
      :state,
      :zip,
      :is_default
    )
  end
end
