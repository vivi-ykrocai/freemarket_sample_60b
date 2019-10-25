class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nick_name last_name family_name last_name_kana family_name_kana birthday phone_number postal_code prefectures city address building_name phone_number2 iine mer_point icon_image phone_number2])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nick_name, :icon_image, :profiile_comments])
  end

end
