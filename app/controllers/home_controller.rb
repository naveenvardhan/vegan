class HomeController < ApplicationController
  before_action :set_cart

  def index
    @items = Item.all
    q = "%#{params[:query]}%"
    @items = @items.where("name ILIKE ? OR description ILIKE ?", q, q)
  end
end
