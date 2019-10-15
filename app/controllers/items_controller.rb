class ItemsController < ApplicationController
  
  def index
  end

  def purchase
  end

  def new
    @item = Item.new
  end
  
  def shousai
  end

  def create
    # binding.pry
    Item.create(name: item_params[:name], image: item_params[:image], item_status: item_params[:item_status], delivery_charged: item_params[:delivery_charged], delivery_method: item_params[:delivery_method], delivery_area: item_params[:delivery_area], delivery_shipping_date: item_params[:delivery_shipping_date], total_price: item_params[:total_price], item_profile_comment: item_params[:item_profile_comment], item_salse_status: item_params[:item_salse_status], good: item_params[:good])
    redirect_to action: :index
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :image, :item_status, :delivery_charged, :delivery_method, :delivery_area, :delivery_shipping_date, :total_price, :item_profile_comment, :item_salse_status, :good)
  end
end
