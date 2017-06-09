class ApplicationController < ActionController::Base
  # 認証済みのユーザの確認
  # session#create未実装なので保留
  #before_filter :authenticate_user!

  # deviseのコントローラーの時に、下記メソッドを呼ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protect_from_forgery except: :sign_in

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:password])
  end
end
