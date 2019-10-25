class SignupController < ApplicationController

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
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

  def step3
    # step2で入力された値をsessionに保存
    session[:phone_number] = user_params[:phone_number]
    @user = User.new # 新規インスタンス作成
    @prefectures = Prefecture.all
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
      postal_code: user_params[:postal_code],
      prefectures: user_params[:prefectures],
      city: user_params[:city],
      address: user_params[:address],
      building_name: user_params[:building_name],
      phone_number2: user_params[:phone_number2]
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
      redirect_to step4_signup_index_path
    else
      render '/signup/error'
    end
  end

    def step4
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
