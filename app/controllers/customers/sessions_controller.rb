class Customers::SessionsController < Devise::SessionsController
  # layout "authentication"

  def new
    self.resource = Customer.new
    super
  end

  def create_old
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
  
  def create
    self.resource = Customer.new(sign_in_params)

    customer = Customer.find_by(
      # name: params[:customer][:name],
      phone: params[:customer][:phone]
    )

    if customer.present?
      sign_in(:customer, customer)

      flash[:notice] = "Logged in successfully"

      redirect_to root_path, status: :see_other
    else
      resource.errors.add(:name, "is invalid") if params[:customer][:name].blank?
      resource.errors.add(:phone, "is invalid") if params[:customer][:phone].blank?

      if customer.nil? && params[:customer][:name].present? && params[:customer][:phone].present?
        resource.errors.add(:base, "Invalid Name or Mobile Number")
      end

      render :new, status: :unprocessable_entity
    end
  end

end
