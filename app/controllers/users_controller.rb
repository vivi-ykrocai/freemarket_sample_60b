class UsersController < ApplicationController
  include CommonActions
  before_action :set_categories
  
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
  end

  def identification
  end

  def profile
  end

end
