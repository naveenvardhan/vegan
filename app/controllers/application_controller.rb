class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_customer

  def set_cart
    if current_customer
      @cart ||= Cart.find_or_create_by(customer_id: current_customer.id, status: 'active')
    else
      session[:cart_token] ||= SecureRandom.uuid
      @cart ||= Cart.find_or_create_by(session_id: session[:cart_token], status: 'active')
    end
  end

  # def current_customer
  #   binding.pry
  #   if session[:customer_id]
  #     Customer.find_by_id session[:customer_id]
  #   else
  #     # session[:customer_id] ||= Customer.last.id
  #     Customer.last
  #     # nil
  #   end
  # end

  protected

  def configure_permitted_parameters
    # Permit custom fields for sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :business_type, :business_name])
    # Permit custom fields for account update
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :business_type, :business_name])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  # def after_sign_up_path_for(resource)
  #   # debugger
  # 
  #   if session[:return_to] == new_order_path
  #     # Force user to add an address after signup
  #     new_address_path(redirect_to_checkout: true)
  #   else
  #     root_path
  #   end
  # end
  
  def after_sign_up_path_for(resource)
    debugger
    
    if session[:return_to].present?
      # Clear the session after taking the value
      path = session.delete(:return_to) 
      new_address_path(redirect_to_checkout: true)
    else
      cart_path
    end
  end
end
