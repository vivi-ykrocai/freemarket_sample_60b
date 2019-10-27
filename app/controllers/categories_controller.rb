class CategoriesController < ApplicationController
  include CommonActions
  before_action :set_categories

  def index
    @parent_categories = Category.where(ancestry: nil).order("id ASC")
  end

  def show
    @category = Category.find(params[:id])

    if @category.has_children?
      @category_items = Item.where(category_id: @category.descendant_ids).order("id DESC").limit(100)
    else
      @category_items = Item.where(category_id: @category.id).order("id DESC").limit(100)
    end
  end

end
