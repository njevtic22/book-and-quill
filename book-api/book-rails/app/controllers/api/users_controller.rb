class Api::UsersController < ApplicationController
  def index
    page, size = get_pagination_params
    sort_by = parse_sort
    # TODO: don't pass whole params
    users = UserSearch.build(User.all, params, sort_by)
    result = Paginator.paginate(page, size, users)
    result.data = UserSerializer.as_json(result.data)
    render json: result
  end
end
