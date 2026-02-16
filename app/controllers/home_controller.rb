class HomeController < ApplicationController
  before_action :set_cart

  # def index
  #   @items = Item.all
  #   q = "%#{params[:query]}%"
  #   @items = @items.where("name ILIKE ? OR description ILIKE ?", q, q)
  # end

  def index
    if params[:query].present?
      @items = Item.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @items = Item.all
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

end
