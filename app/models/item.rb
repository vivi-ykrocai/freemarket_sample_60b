class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  enum item_status: {
    "新品、未使用":1, "未使用に近い":2, "目立った傷や汚れなし":3,
    "やや傷や汚れあり": 4, "傷や汚れあり":5, "全体的に状態が悪い":6
  }
  enum delivery_shipping_date: {
    "1~2日で発送":1, "2~3日で発送":2, "4~7日で発送":3
  }
  enum delivery_charged: {
    "送料込み（出品者負担）":1, "着払い（購入者負担）":2
  }

  enum delivery_method: {
    "未定":1, "クロネコヤマト":6, "ゆうパック":7, "ゆうメール":3,
    "らくらくメルカリ便":2,  "レターパック":4, "普通郵便（定形、定形外）":5,
    "クリックポスト":8, "ゆうパケット":9
  }

  belongs_to :category
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :seller, class_name: "User", optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images


  validates :name, :item_status, :delivery_charged, :delivery_method, :delivery_area, :delivery_shipping_date, :total_price, :category_id, :item_profile_comment,  presence: true
end




