class ItemsController < ApplicationController
  include CommonActions
  before_action :set_categories

  before_action :set_item, only: [:purchase, :pay, :buyer_add, :show, :detail, :edit, :update, :destroy, :transcation, :stop_selling, :restart_selling, :completion]
  after_action :buyer_add, only: [:pay]

  def index
    # ブランドはまだ未実装、発送完了の商品と公開停止の商品は一覧から外す
    @items = Item.where(item_salse_status: nil).order("created_at DESC").limit(10)
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
    @delivery_method_cod = Item.delivery_methods.keys
    @delivery_method_pod = Item.delivery_methods.keys.slice(0,4)
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
    if @item.seller_id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      redirect_to detail_item_path(@item), notice: "商品の削除はできません"
    end
  end

  def transcation
    total_price = @item.total_price
    fee = (@item.total_price) / 10
    @fee = fee.to_s(:delimited)
    @profit = (total_price - fee).to_s(:delimited)
    @postal_code= @item.buyer.postal_code
  end

  def stop_selling
    if @item.update(item_salse_status: current_user.id)
      redirect_to detail_item_path(@item), notice: "出品の一旦停止をしました"
    else
      redirect_to detail_item_path(@item), notice: "公開停止にできませんでした"
    end
  end

  def restart_selling
    if @item.update(item_salse_status: nil)
      redirect_to detail_item_path(@item), notice: "出品の再開をしました"
    else
      redirect_to detail_item_path(@item), notice: "出品の再開ができませんでした"
    end
  end

  def completion
    if @item.update(item_salse_status: current_user.id)
      redirect_to completion_user_path(current_user)
    else
      redirect_to transcation_item_path(@item), notice: "商品の発送ができませんでした"
    end
  end

  def create
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
