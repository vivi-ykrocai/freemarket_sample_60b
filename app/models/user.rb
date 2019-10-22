class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
        

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  has_many :items
  has_many :cards
  # belongs_to :registration_style
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sns_credentials, dependent: :destroy


  def self.find_oauth(auth)
    # OAuthの情報でユーザーを見つける
    uid = auth.uid
    provider = auth.provider
    sns = SnsCredential.where(uid: uid, provider: provider).first
     if sns.present?
      user = User.where(id: sns.user_id).first
      # idとsnsクレデンシャルのidが一緒の物を探して、最初の物を持って来る。
    else
      # 登録していないSNSを利用してログインしようとした時に
      user = User.where(email: auth.info.email).first
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


  validates :nick_name, presence: true
  validates :nick_name, uniqueness: true
  validates :last_name, presence: true
  validates :family_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :family_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 7 }
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
