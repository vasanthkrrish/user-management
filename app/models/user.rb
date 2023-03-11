class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :timeoutable
  before_save :skip_confirmation
  after_save :confirm_user
  scope :users, -> { where(admin: false).order(updated_at: :desc) }

  validates :email, :username, presence: true, uniqueness: true

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

  def self.grid_data
    columns = [
      {
        headerName: 'User Name',
        field: 'username'
      },
      {
        headerName: 'Email',
        field: 'email'
      },
      {
        headerName: 'First Name',
        field: 'first_name'
      },
      {
        headerName: 'Last Name',
        field: 'last_name'
      },
      {
        headerName: 'Contact',
        field: 'contact'
      },
      {
        headerName: 'Company',
        field: 'company'
      },
      {
        headerName: 'Company Address',
        field: 'company_address'
      }
    ]
    columns.each do |i|
      i['filter'] = true
      i['sortable'] = true
      i['floatingFilter'] = true
    end
  end

  def as_json(opts = {})
    super(opts.merge(only: %i[id username email first_name last_name contact company company_address]))
  end

  protected

  def password_required?
    false
  end
end
