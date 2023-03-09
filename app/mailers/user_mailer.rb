class UserMailer < Devise::Mailer
  def confirmation_instructions(resource, token, opts = {})
    @user = resource
    port = begin
             Rails::Server::Options.new.parse!(ARGV)[:Port]
           rescue StandardError
             5000
           end
    @confirmation_link = Rails.application.routes.url_helpers.edit_user_password_url(reset_password_token: token,
                                                                                        host: "localhost:#{port}")
    opts[:subject] = 'Reset Password'
    opts[:to] = resource.email
    devise_mail(resource, :confirmation_instructions, opts)
  end
end
