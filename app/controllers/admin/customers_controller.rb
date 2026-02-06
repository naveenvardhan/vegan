class Admin::CustomersController < Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all

    # Filter by Name, Email, or Phone (Text Search)
    if params[:query].present?
      query = "%#{params[:query]}%"
      @customers = @customers.where(
        "name ILIKE ? OR business_name ILIKE ? OR phone ILIKE ?", 
        query, query, query
      )
    end

    # Filter by Status (Active/Inactive)
    if params[:status].present?
      @customers = @customers.where(is_active: params[:status] == "active")
    end

    # Keep the sorting consistent
    @customers = @customers.order(created_at: :desc)
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to admin_customers_path, notice: 'Customer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # PATCH/PUT /customers/1
  def update
    # If password field is blank, don't try to update it
    if params[:customer][:password].blank?
      params[:customer].delete(:password)
      params[:customer].delete(:password_confirmation)
    end

    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: 'Customer updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :phone, :email, :gender, :is_active, :password, :password_confirmation, :business_name, :business_type, :aadhar_number)
  end
  
  # In your SessionsController or a Warden callback
  # def merge_guest_cart!
  #   guest_cart = Cart.find_by(session_id: session[:cart_token])
  #   if guest_cart && current_customer
  #     user_cart = Cart.find_or_create_by(customer_id: current_customer.id, status: 'active')
  # 
  #     guest_cart.cart_items.each do |item|
  #       # Check if item already exists in user cart to avoid duplicates
  #       existing_item = user_cart.cart_items.find_by(item_id: item.item_id)
  #       if existing_item
  #         existing_item.update(quantity: existing_item.quantity + item.quantity)
  #       else
  #         item.update(cart_id: user_cart.id)
  #       end
  #     end
  #     guest_cart.destroy # Clean up the guest cart
  #   end
  # end
end