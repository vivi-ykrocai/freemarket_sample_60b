class UsersController < ApplicationController
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
    @items = current_user.saling_items.order("created_at DESC")
  end

  def progression
  end

  def completion
  end

  def card
    if @card.save
      redirect_to action: "show"
    else
      redirect_to action: "pay"
    end
  end

  def identification
  end

  def profile
  end

end
