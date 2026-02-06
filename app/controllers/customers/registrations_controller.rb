class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :set_cart

  protected
  
#   Started POST "/customers" for ::1 at 2026-02-01 18:45:07 +0530
# Processing by Customers::RegistrationsController#create as TURBO_STREAM
#   Parameters: {"authenticity_token"=>"[FILTERED]", "customer"=>{"name"=>"", "phone"=>"", "business_name"=>"", "business_type"=>"Hotels & Restaurants"}, "commit"=>"Sign up"}


  def after_sign_up_path_for(resource)
    # This sends them to add an address immediately after the form is submitted
    # new_address_path(redirect_to_checkout: true)
    cart_path
  end
end

# Kalabairava astam
