class CategoriesController < ApplicationController
  include CommonActions
  before_action :set_categories

  def index
    @parent_categories = Category.where(ancestry: nil).order("id ASC")
  end
end
