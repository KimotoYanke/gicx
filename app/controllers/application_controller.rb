class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception
  protected

  def configure_permitted_parameters
    added_attrs = [:uid, :password, :password_confirmation, :remember_me, :homeroom_id]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
