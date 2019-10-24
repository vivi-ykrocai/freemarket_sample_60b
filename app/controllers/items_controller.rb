class ItemsController < ApplicationController

  before_action :set_item, only: [:purchase, :pay, :buyer_add, :show, :detail, :edit, :update, :destroy, :transcation, :stop_selling, :restart_selling, :completion]
  after_action :buyer_add, only: [:pay]

  def index
    @items = Item.where(item_salse_status: nil).order("created_at DESC").limit(10)
  end

  def purchase
    @total_price = @item.total_price.to_s(:delimited)
  end

  def new
    @item = Item.new
    @item.images.build  # itemレコードが保存された際にimageレコードにも保存をかける
    @category_parents = Category.where(ancestry: nil).map{|i| [i.name, i.id]}
    @item_status = Item.item_statuses.keys
    @delivery_charged = Item.delivery_chargeds.keys
    @delivery_method_cod = Item.delivery_methods.keys
    @delivery_method_pod = Item.delivery_methods.keys.slice(0,4)
    @delivery_area = Prefecture.all
    @delivery_shipping_date = Item.delivery_shipping_dates.keys
  end

  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children     #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  # def get_delivery_method
  #   @delivery_method_cod = Item.delivery_methods.keys
  #   @delivery_method_pod = Item.delivery_methods.keys.slice(0,4)
  # end

  def show
    @images = @item.images
    @total_price = @item.total_price.to_s(:delimited)
  end

  def edit
    # @output_fee = (@item.total_price/10)
    total_price = @item.total_price
    fee = (@item.total_price) / 10
    @fee = fee.to_s(:delimited)
    @profit = (total_price - fee).to_s(:delimited)
  end

  def detail
    @images = @item.images
  end

  def update
    if @item.update(item_params)
      redirect_to detail_item_path
    else
      render :edit
    end
  end

  def destroy
    #  if @item.seller_id == current_user.id
      @item.destroy
      redirect_to root_path
    # end
    # ログイン機能が完成したらコメントアウトした部分を追加する。
  end

  def transcation
    total_price = @item.total_price
    fee = (@item.total_price) / 10
    @fee = fee.to_s(:delimited)
    @profit = (total_price - fee).to_s(:delimited)
    @postal_code= @item.buyer.postal_code
    # @postal_code= @item.buyer.postal_code.gsub(/#{@item.buyer.postal_code.to_s}/,/^〒\s[0-9]{3}-[0-9]{4}$/)
  end

  def stop_selling
    @item.update(item_salse_status: current_user.id)
    redirect_to detail_item_path(@item), notice: "出品の一旦停止をしました"
  end

  def restart_selling
    @item.update(item_salse_status: nil)
    redirect_to detail_item_path(@item), notice: "出品の再開をしました"
  end

  def completion
    @item.update(item_salse_status: current_user.id)
    redirect_to completion_user_path(current_user)
  end

  def create
    # binding.pry
    @item = Item.create(item_params)
    redirect_to action: :index
  end

  def pay
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.create(
    amount: @item.total_price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to root_path, notice: '決済が完了しました'
  end

  # 商品購入が成功したらbuyer_idを付与する
  def buyer_add
    @item.update(buyer_id: current_user.id)
  end


  private

  def item_params
    params.require(:item).permit(:name, :image, :item_status, :delivery_charged,:delivery_method, :delivery_area, :delivery_shipping_date, :total_price, :item_profile_comment, :item_salse_status, :good, :category_id, images_attributes: [:id, :image]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
    @images = @item.images
  end

end
