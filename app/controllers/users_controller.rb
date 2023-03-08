class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :authenticate_admin!, except: :show

  def index
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end
end
