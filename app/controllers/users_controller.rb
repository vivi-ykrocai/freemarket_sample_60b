class UsersController < ApplicationController
  def index
  end

  def logout
  end

  def card
  end

  def identification
  end
  
  def henshuu
  end

  def selling
    @items = Item.order("created_at DESC")  #user機能を実装したら変更
  end

  def progression
  end

  def completion
  end
end


