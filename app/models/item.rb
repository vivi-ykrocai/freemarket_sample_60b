class Item < ApplicationRecord

  belongs_to :user
  # has_many :comments
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

end

