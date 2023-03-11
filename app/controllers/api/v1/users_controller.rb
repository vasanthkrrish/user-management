class Api::V1::UsersController < ActionController::API
  def index
    render json: {
      users: User.users.as_json
    }
  end

  def grid_data
    render json: {
      columns: User.grid_data
    }
  end

  def check_field
    render json: if params[:email]
      User.any? { |e| e.email == (params[:email] || '') }
    elsif params[:username]
      User.any? { |e| e.username == (params[:username] || '') }
    else
      false
    end
  end
end
