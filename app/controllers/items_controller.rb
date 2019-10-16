class ItemsController < ApplicationController

  def index
    @items = Item.order("created_at DESC").limit(10)
  end

  def purchase
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    Item.create(name: item_params[:name], image: item_params[:image], item_status: item_params[:item_status], delivery_charged: item_params[:delivery_charged], delivery_method: item_params[:delivery_method], delivery_area: item_params[:delivery_area], delivery_shipping_date: item_params[:delivery_shipping_date], total_price: item_params[:total_price], item_profile_comment: item_params[:item_profile_comment], item_salse_status: item_params[:item_salse_status], good: item_params[:good])
    redirect_to action: :index
  end
  
  def pay
    # @item = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.create(
    amount: 2000000,
    #amountは一旦仮置きで3500とする。
    # 後で amount: @item.total_price,にする
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to root_path, notice: '決済が完了しました'
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :image, :item_status, :delivery_charged,
      :delivery_method, :delivery_area, :delivery_shipping_date,
      :total_price, :item_profile_comment, :item_salse_status,
      :good)  #user機能実装したら）の後ろに追記    .merge(user_id: current_user.id)
  end

end
