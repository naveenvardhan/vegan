class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = Item.all

    # Search by Name or Description
    if params[:query].present?
      q = "%#{params[:query]}%"
      @items = @items.where("name ILIKE ? OR description ILIKE ?", q, q)
    end

    # Filter by Category
    if params[:category].present?
      @items = @items.where(category: params[:category])
    end

    @items = @items.order(:name)
  end

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "Item created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admin_items_path, notice: "Item updated successfully."
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:item).permit(:name, :category, :mrp, :price, :quantity, :unit, :description)
  end
end