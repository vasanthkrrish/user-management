class PasswordsController < Devise::PasswordsController
  def create
    token = Devise.token_generator.digest(resource_class, :reset_password_token, params[:user][:reset_password_token])
    user = User.find_by(reset_password_token: token)
    if user
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      if user.save
        flash[:notice] = 'Password set successfully'
        redirect_to root_path
      else
        flash[:error] = user.errors.full_messages.join(', ')
        render 'edit'
      end
    end
  end
end
