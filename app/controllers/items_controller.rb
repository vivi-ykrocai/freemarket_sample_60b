class ItemsController < ApplicationController
  
  def index
    @items = Item.order("created_at DESC").limit(10)
  end

  def purchase
  end

  def sell
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
end
