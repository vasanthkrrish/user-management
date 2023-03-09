class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin,  only: %i[new create]
  skip_before_action :require_no_authentication

  def create
    @user = User.new(user_params)
    if @user.save
      token = User.generate_password_token(@user.reload)
      UserMailer.confirmation_instructions(@user, token).deliver_now
      flash.now[:notice] = 'User successfully created'
      redirect_to root_path
    else
      @messages = @user.errors.full_messages.join(', ')
      flash.now[:error] = @messages
    end
  end

  private

  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:error] = 'Only admins can do that'
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :company, :company_address, :contact)
  end
end
