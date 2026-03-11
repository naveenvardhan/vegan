class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = Item.all

    # Search by Name or Description
    if params[:query].present?
      q = "%#{params[:query]}%"
      @items = @items.where("name ILIKE ? OR sub_category ILIKE ?", q, q)
    end

    # Filter by Category
    if params[:category].present?
      @items = @items.where(category: params[:category])
    end
    
    if params[:type].present?
      @items = @items.for_hotel if params[:type] == 'hotel'
      @items = @items.for_seller if params[:type] == 'seller'
    end

    @items = @items.order(:priority)
    @grouped_items = @items.group_by(&:sub_category).transform_values { |items| items.sort_by { |i| i.priority || 9999 } }

  end

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to admin_items_path, notice: "Item created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def update
  #   if @item.update(item_params)
  #     redirect_to admin_items_path, notice: "Item updated successfully."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end
  
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      if params[:item][:unit].present?
        redirect_to admin_items_path, notice: "Updated successfully"
      else
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_items_path, notice: "Updated successfully" }
        end
      end
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_items_path, notice: "Item deleted.", status: :see_other
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :mrp, :price, :seller_price, :quantity, :unit, :description, :grade, :sub_category, :show_for_hotel, :show_for_seller, :priority)
  end
end