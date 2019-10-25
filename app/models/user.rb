class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  mount_uploader :icon_image, ImageUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_many :items
  has_one :card
  # belongs_to :registration_style

  # 出品した商品ー出品中
  has_many :selling_items, -> { where("buyer_id is NULL && item_salse_status is NULL") }, foreign_key: "seller_id", class_name: "Item"
  # 出品した商品ー取引中
  has_many :progression_items, -> { where("buyer_id is not NULL && item_salse_status is NULL") }, foreign_key: "seller_id", class_name: "Item"
  # 出品した商品ー売却済
  has_many :completion_items, -> { where("item_salse_status is not NULL && buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
  # 出品した商品ー公開停止中
  has_many :stop_selling_items, -> { where("item_salse_status is not NULL && buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  # 購入した商品ー取引中
  has_many :during_trading_items, -> { where("item_salse_status is NULL") }, foreign_key: "buyer_id", class_name: "Item"
  # 出品した商品ー過去の取引
  has_many :buyed_items, -> { where("item_salse_status is not NULL") }, foreign_key: "buyer_id", class_name: "Item"


  def show
    @user = User.find(params[:id])
  end

  def self.find_oauth(auth)
    # OAuthの情報でユーザーを見つける
    uid = auth.uid
    provider = auth.provider
    sns = SnsCredential.find_by(uid: uid, provider: provider)
     if sns.present?
      user = User.find_by(id: sns.user_id)
      # idとsnsクレデンシャルのidが一緒の物を探して、最初の物を持って来る。
    else
      # 登録していないSNSを利用してログインしようとした時に
      user = User.find_by(email: auth.info.email)
      if user.present?
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
        return { user: user, sns: sns }
      else
        password = Devise.friendly_token[0, 20]
        user = User.new(
          nick_name: auth.info.name,
          email:    auth.info.email,
          password: password,
          password_confirmation: password
          )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      end
    end
    return { user: user, sns: sns }
  end


  validates :nick_name, presence: true, on: :create
  validates :nick_name, uniqueness: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :family_name, presence: true, on: :create
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }, on: :create
  validates :family_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }, on: :create
  validates :email, presence: true, on: :create
  validates :email, uniqueness: true, on: :create
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 7 }, on: :create
  validates :birthday, presence: true, on: :create
  validates :phone_number, presence: true, on: :create
  validates :phone_number, uniqueness: true, on: :create
  validates :phone_number, length: { is: 11 }, on: :create
  validates :postal_code, presence: true, on: :create
  validates :postal_code, length: { is: 7 }, on: :create
  validates :prefectures, presence: true, on: :create
  validates :city, presence: true, on: :create
  validates :address, presence: true, on: :create
end
