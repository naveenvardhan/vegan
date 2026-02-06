class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: %i[show edit update destroy]
  
  # layout 'admin'

  def index
    @orders = Order.includes(:customer).all

    # Search by Invoice Number
    if params[:invoice].present?
      @orders = @orders.where("invoice_number ILIKE ?", "%#{params[:invoice]}%")
    end

    # Filter by Status
    if params[:status].present?
      @orders = @orders.where(status: params[:status])
    end

    # Filter by Date Range (Optional but highly recommended for Orders)
    if params[:start_date].present? && params[:end_date].present?
      @orders = @orders.where(order_date: params[:start_date]..params[:end_date])
    end

    @orders = @orders.order(created_at: :desc)
  end

  def new
    @order = Order.new
    @order.order_items.build # Start with one blank item
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to admin_orders_path, notice: "Order created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      redirect_to admin_order_path @order, notice: "Order updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def download
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@order)
        send_data pdf.render, 
          filename: "invoice_#{@order.invoice_number}.pdf",
          type: "application/pdf",
          disposition: "inline" # "inline" displays in browser, "attachment" downloads it
          # disposition: "attachment" # "inline" displays in browser, "attachment" downloads it
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :customer_id, :vendor_id, :farmer_id, :delivery_type, :status, 
      :delivery_charge, :discount, :order_date,
      order_items_attributes: [:id, :item_id, :quantity, :price_at_order, :_destroy]
    )
  end
end