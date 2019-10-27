class UsersController < ApplicationController
  include CommonActions
  before_action :set_categories
  

  before_action :purchase, only: :show
  before_action :purchased, only: :show

  def step1
  end

  def step2
  end

  def step3
  end

  def step4
  end

  def show
    @user = User.find(params[:id])
  end

  def logout

  end

  def selling
    @selling_items = current_user.selling_items
    @stop_selling_items = current_user.stop_selling_items
    @sell_items = @selling_items + @stop_selling_items
  end

  def progression
    @items = current_user.progression_items.order("created_at DESC").limit(12)
  end

  def completion
    @items = current_user.completion_items.order("updated_at DESC").limit(12)
  end

  def purchase
    @during_items = current_user.during_trading_items.order("updated_at DESC")
  end

  def purchased
    @buyed_items = current_user.buyed_items.order("updated_at DESC")
  end

  def card
  end

  def identification  #本人情報確認
    @address = Address.new
    @prefecture = Prefecture.all
  end

  def address_create  #Addressテーブルに保存（新規作成）
    if current_user.address.present?
      # address_update
      @address = Address.create(address_params)
    else
      @address = Address.create(address_params)
      redirect_to identification_user_path
    end
  end

  def address_update  #Addressテーブルを編集（変更）
    @address = current_user.address
    if @address.update(address_params)
      redirect_to identification_user_path
    else
      redirect_to identification_user_path, notice: "本人情報に不備があります"
    end
  end


  
  def profile
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      current_user.update(user_params)
      redirect_to profile_user_path, notice: 'プロフィールを更新しました'
    else
      redirect_to profile_user_path, notice: "編集に失敗しました"
    end
  end

  private
  def user_params
    params.require(:user).permit(:nick_name, :icon_image, :profiile_comments)
  end
  
  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :city, :address, :apartment_house).merge(user_id: current_user.id)
  end

end
