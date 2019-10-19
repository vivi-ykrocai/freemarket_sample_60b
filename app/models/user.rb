class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
        #  :omniauthable, omniauth_providers: [:google_oauth2]
         
  # has_many :items
  # has_one :address
  # has_one :credit_card
  # belongs_to :registration_style
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sns_credentials, dependent: :destroy



  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.creae(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nick_name: auth.info.name,
          email:auth.info.email,
        )
        sns = SnsCredential.new(
          uid:auth.uid,
          provider: auth.provider
        )
      end
      return  { user: user, sns: sns }
    end


    def self.with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      unless user.present?
        user = User.new(
          nick_name: auth.info.name,
          email: auth.info.email,
        )
      end
      return {user: user}
    end

    def self.find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = SnsCredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      return { user: user ,sns: sns}
    end
  end
