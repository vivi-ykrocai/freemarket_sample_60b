class UsersController < ApplicationController
  def names
  end

  def telephones
  end

  def addresses
  end

  def cards
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
  end

  def identification
  end

  def profile
  end

end
