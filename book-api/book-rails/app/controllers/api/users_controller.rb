class Api::UsersController < ApplicationController
  def index
    page, size = get_pagination_params

    users = UsersQuery.build(User.all, params)

    pagination_metadata = get_pagination_metadata(records: users, size: size)

    result = UserSerializer.as_json(users.offset(page * size).limit(size))
    render json: pagination_metadata.merge(data: result)    # creates new hash
    # render json: pagination_metadata.merge!(data: result) # mutates the original
  end
end
