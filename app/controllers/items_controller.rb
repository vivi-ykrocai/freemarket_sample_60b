class ItemsController < ApplicationController

  before_action :set_item, only: [:purchase, :pay, :buyer_add, :show, :detail, :edit, :update, :destroy]
  after_action :buyer_add, only: [:pay]

  def index
    # ブランドはまだ未実装なので、とりあえず全ての商品を表示させる
    @items = Item.order("created_at DESC").limit(10)
    
    # カテゴリーごとの商品表示
    @lady_category = Category.find(1)
    @men_category = Category.find(200)
    @electrical_category = Category.find(898)
    @toy_category = Category.find(685)

    @ladies_items = Item.where(category_id: @lady_category.indirect_ids).order("created_at DESC").limit(10)
    @mens_items = Item.where(category_id: @men_category.indirect_ids).order("created_at DESC").limit(10)
    @electrical_appliance_items = Item.where(category_id: @electrical_category.indirect_ids).order("created_at DESC").limit(10)
    @toy_hobby_items = Item.where(category_id: @toy_category.indirect_ids).order("created_at DESC").limit(10)
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

  def show
    @total_price = @item.total_price.to_s(:delimited)
    @user_items = Item.where(seller_id: @item.seller).where.not(id: @item.id).order("created_at DESC").limit(6)
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

  def create
    # Item.create(name: item_params[:name], image : item_params[:image], item_status: item_params[:item_status], delivery_charged: item_params[:delivery_charged], delivery_method: item_params[:delivery_method], delivery_area: item_params[:delivery_area], delivery_shipping_date: item_params[:delivery_shipping_date], total_price: item_params[:total_price], item_profile_comment: item_params[:item_profile_comment], item_salse_status: item_params[:item_salse_status], good: item_params[:good], category_id: item_params[:category_id])
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
