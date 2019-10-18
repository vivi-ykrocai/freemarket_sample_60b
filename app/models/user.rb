class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  # has_one :address
  # has_one :credit_card
  # belongs_to :registration_style
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"

  validates :nick_name, presence: true
  validates :nick_name, uniqueness: true
  validates :last_name, presence: true
  validates :family_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :family_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password,    length: { minimum: 7 }
  validates :birthday, presence: true
  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :phone_number, length: { is: 11 } 
  validates :postal_code, presence: true
  validates :postal_code, length: { is: 7 } 
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :address, presence: true


end




