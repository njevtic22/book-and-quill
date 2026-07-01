class Api::UsersController < ApplicationController
  def index
    # TODO: add sorting
    page, size = get_pagination_params
    # TODO: don't pass whole params
    users = UserSearch.build(User.all, params)
    result = Paginator.paginate(page, size, users)
    result.data = UserSerializer.as_json(result.data)
    render json: result
  end
end
