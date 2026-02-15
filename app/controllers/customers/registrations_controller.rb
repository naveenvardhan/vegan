class Customers::RegistrationsController < Devise::RegistrationsController
  # before_action :set_cart
  def create
    super do |resource|
      if resource.persisted?
        # This block only runs if the customer was successfully saved
        if session[:return_to].present?
          # We don't even need after_sign_up_path_for if we handle it here
          session.delete(:return_to)
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: new_address_path(redirect_to_checkout: true)
          return
        end
      end
    end
  end

  protected
  
#   Started POST "/customers" for ::1 at 2026-02-01 18:45:07 +0530
# Processing by Customers::RegistrationsController#create as TURBO_STREAM
#   Parameters: {"authenticity_token"=>"[FILTERED]", "customer"=>{"name"=>"", "phone"=>"", "business_name"=>"", "business_type"=>"Hotels & Restaurants"}, "commit"=>"Sign up"}


  def after_sign_up_path_for(resource)
    if session[:return_to].present?
      session.delete(:return_to)
      new_address_path(redirect_to_checkout: true)
    else
      cart_path
    end
  end

end

# Kalabairava astam
