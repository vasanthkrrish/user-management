class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin!
    authenticate_user!
    redirect_to user_path(current_user.id) unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
  end
end
