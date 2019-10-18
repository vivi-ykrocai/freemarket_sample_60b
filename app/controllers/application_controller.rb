class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :last_name, :family_name, :last_name_kana, :family_name_kana, :birthday, :phone_number, :postal_code, :prefectures, :city, :address, :building_name, :phone_number2, :iine, :mer_point, :icon_image])
  end 

end



