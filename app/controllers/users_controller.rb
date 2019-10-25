class UsersController < ApplicationController

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

  def identification
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
  

end
