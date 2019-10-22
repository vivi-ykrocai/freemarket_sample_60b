class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end


# 1
  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"]) 
    @user = info[:user]
    @sns = info[:sns]
    if @sns.persisted?
      sign_in_and_redirect @user, event: :authentication #after_sign_in_path_forと同じパス
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    elsif request.env["omniauth.origin"].include?("sign_up")
      session["devise.auth_data"] = request.env["omniauth.auth"].except("extra")
      render template: "signup/step1"
    else
      redirect_to request.env["omniauth.origin"], flash: { error: :"#{provider}での登録情報がありません。他の方法でのログインをお試しください。" }
      set_flash_message(:alert, :"#{provider}での登録情報がありません。他の方法でのログインをお試しください。")
    end
  end

  def failure
    redirect_to root_path and return
  end

# 2
# def callback_for(provider)
#   info = User.find_oauth(request.env["omniauth.auth"]) 
#   @user = info[:user]
#   sns_id = info[:sns_id]
#   if @user.persisted? 
#     sign_in_and_redirect @user, event: :authentication
#     set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
#   else 
#     session["devise.sns_id"] = sns_id 
#     render template: "signup/step1" 
#   end
# end

# def failure
#   redirect_to root_path and return
# end




end

