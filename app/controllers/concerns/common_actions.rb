module CommonActions
  extend ActiveSupport::Concern

  def set_categories
  @categories = Category.where(ancestry: nil).order("id ASC")
  end
end