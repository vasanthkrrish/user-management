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
end
