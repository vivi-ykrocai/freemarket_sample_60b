class SignupController < ApplicationController
  before_action :validates_names, only: :telephones # step1のバリデーション
  before_action :validates_telephones, only: :addresses # step1のバリデーション
  before_action :validates_addresses,  only: :create

  def names
    @user = User.new # 新規インスタンス作成
  end

    #  バリデーションのチェック1ページ目
  def validates_names
    session[:nick_name] = user_params[:nick_name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:family_name] = user_params[:family_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:family_name_kana] = user_params[:family_name_kana]
    session["birthday(1i)"] = params[:birthday]["birthday(1i)"]
    session["birthday(2i)"] = params[:birthday]["birthday(2i)"]
    session["birthday(3i)"] = params[:birthday]["birthday(3i)"]

    @user = User.new(
      nick_name: session[:nick_name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: user_params[:last_name], # 入力前の情報は、バリデーションに通る値を仮で入れる
      family_name: user_params[:family_name], 
      last_name_kana: user_params[:last_name_kana], 
      family_name_kana: user_params[:family_name_kana], 
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      phone_number: "00000000000",
      postal_code: '0000000',
      prefectures: '沖縄県',
      city: '那覇市',
      address: '224'
    )
    render 'signup/names' unless @user.valid?

  end
  
  # 2ページ目
  def telephones
    
    # namesで入力された値をsessionに保存
    session[:nick_name] = user_params[:nick_name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:family_name] = user_params[:family_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:family_name_kana] = user_params[:family_name_kana]
    session["birthday(1i)"] = params[:birthday]["birthday(1i)"]
    session["birthday(2i)"] = params[:birthday]["birthday(2i)"]
    session["birthday(3i)"] = params[:birthday]["birthday(3i)"]
    
    @user = User.new # 新規インスタンス作成
  end

  # 2ページ目のバリデーションチェック
  def validates_telephones
    session[:phone_number] = user_params[:phone_number]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nick_name: session[:nick_name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], # 入力前の情報は、バリデーションに通る値を仮で入れる
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      phone_number: session[:phone_number],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      postal_code: '0000000',
      prefectures: '沖縄県',
      city: '那覇市',
      address: '224'
    )
    render 'signup/telephones' unless @user.valid?
  end

      
  def addresses
    # telephonesで入力された値をsessionに保存
    session[:phone_number] = user_params[:phone_number]
    @user = User.new # 新規インスタンス作成
    @prefectures = Prefecture.all
    # binding.pry
  end

  def validates_addresses
    session[:postal_code] = user_params[:postal_code]
    session[:prefectures] = user_params[:prefectures]
    session[:city] = user_params[:city]
    session[:address] = user_params[:address]
    session[:building_name] = user_params[:building_name]
    session[:phone_number2] = user_params[:phone_number2]

    @user = User.new(
      nick_name: session[:nick_name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], # 入力前の情報は、バリデーションに通る値を仮で入れる
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      phone_number: session[:phone_number],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      # postal_code: user_params[:postal_code],
      # prefectures: user_params[:prefectures],
      # city: user_params[:city],
      # address: user_params[:address],
      # building_name: user_params[:building_name],
      # phone_number2: user_params[:phone_number2]
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      address: session[:address],
      building_name: session[:building_name],
      phone_number2: session[:phone_number2]
    )
    render 'signup/addresses' unless @user.valid?

  end


  def create
    @user = User.new(
      nick_name: session[:nick_name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name],
      family_name: session[:family_name],
      last_name_kana: session[:last_name_kana],
      family_name_kana: session[:family_name_kana],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      phone_number: session[:phone_number],
      # postal_code: user_parmas[:postal_code],
      # prefectures: user_params[:prefectures],
      # city: user_params[:city],
      # address: user_params[:address],
      # building_name: user_params[:building_name],
      # phone_number2: user_params[:phone_number2],
      postal_code: session[:postal_code],
      prefectures: session[:prefectures],
      city: session[:city],
      address: session[:address],
      building_name: session[:building_name],
      phone_number2: session[:phone_number2]
    )

    if @user.save
      session[:id] = @user.id
      if session["devise.auth_data"].present?
        SnsCredential.create(
          uid: session["devise.auth_data"]["uid"],
          provider: session["devise.auth_data"]["provider"],
          user_id: @user.id
        )
      end
      sign_in User.find(session[:id]) unless user_signed_in?
      redirect_to cards_signup_index_path
    else
      render '/signup/sign_up'
    end
  end

    def cards 
      user = User.where(id: current_user.id)
    end
  
    def error
    end
    
    def finish
      sign_in User.find(session[:id]) unless user_signed_in?
      
    end









    


    private

  # 許可するキーを設定します
  def user_params
    params.require(:user).permit(
      :nick_name,
      :email,
      :password,
      :password_confirmation,
      :last_name,
      :family_name,
      :last_name_kana,
      :family_name_kana,
      :birthday,
      :phone_number,
      :postal_code,
      :prefectures,
      :city,
      :address,
      :building_name,
      :phone_number2
    )
  end
end
