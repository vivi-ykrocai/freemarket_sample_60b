class ItemsController < ApplicationController

  def index
  end

  def purchase
  end

  def sell
  end

  def shousai
  end

  def pay
    # binding.pry
    # @item = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.create(
    amount: 2000000,
    #amountは一旦仮置きで3500とする。
    # 後で amount: @item.total_price,にする
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :item_profile_comment,
      :total_price,
    ).merge(user_id: current_user.id)
  end


end
