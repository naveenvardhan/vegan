class Customers::SessionsController < Devise::SessionsController
  # layout "authentication"

  def new
    self.resource = Customer.new
    super
  end

  def create
    customer = Customer.find_by(
      name: params[:customer][:name],
      phone: params[:customer][:phone]
    )

    if customer.present?
      # sign_in(customer)
      sign_in(:customer, customer)

      redirect_to root_path, notice: "Logged in successfully"
    else
      self.resource = Customer.new

      flash.now[:alert] = "Invalid Name or Mobile Number"
      render :new, status: :unprocessable_entity
    end
  end
end
