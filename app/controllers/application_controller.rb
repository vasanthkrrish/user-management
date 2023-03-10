class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :error, :success

  def authenticate_admin!
    authenticate_user!
    redirect_to info_users_path unless current_user.admin?
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_resetting_password_path_for(resource)
    new_user_session_path
  end
end
