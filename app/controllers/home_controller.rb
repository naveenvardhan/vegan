class HomeController < ApplicationController
  before_action :set_cart

  def index
    @items = Item.all
  end
end
