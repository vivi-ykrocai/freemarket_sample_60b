class UsersController < ApplicationController
  def step1
  end

  def step2
  end

  def step3
  end

  def step4
  end

  def index
  end

  def logout
  end

  def selling
    @items = Item.order("created_at DESC")  #user機能を実装したら変更
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

  def henshuu
  end

end
