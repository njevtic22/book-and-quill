class Api::UsersController < ApplicationController
  def index
    render json: UserSerializer.as_json(User.all)
  end
end
