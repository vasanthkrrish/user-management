class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :timeoutable
  before_save :skip_confirmation
  after_save :confirm_user

  def skip_confirmation
    skip_confirmation_notification!
  end

  def confirm_user
    self.class.confirm_by_token(confirmation_token)
  end

  def self.generate_password_token(resource)
    raw, enc = Devise.token_generator.generate(resource.class, :reset_password_token)
    resource.reset_password_token = enc
    resource.reset_password_sent_at = Time.now.utc
    resource.save!
    raw
  end
end
