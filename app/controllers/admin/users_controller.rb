class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    # Filter by Name, Email, or Phone (Text Search)
    if params[:query].present?
      query = "%#{params[:query]}%"
      @users = @users.where(
        "name ILIKE ? OR email ILIKE ? OR phone ILIKE ?", 
        query, query, query
      )
    end

    # Filter by Status (Active/Inactive)
    # if params[:status].present?
    #   @users = @users.where(is_active: params[:status] == "active")
    # end

    # Keep the sorting consistent
    @users = @users.order(created_at: :desc)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    # If password field is blank, don't try to update it
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :phone, :email, :gender, :is_active, :password, :password_confirmation, :business_name, :business_type, :aadhar_number)
  end
end