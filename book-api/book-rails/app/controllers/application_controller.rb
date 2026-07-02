class ApplicationController < ActionController::API
  DEFAULT_PAGE = 0
  DEFAULT_SIZE = 20
  MAX_SIZE = 1000

  before_action :validate_sort_type

  protected

  def parse_sort
    # Array(elem) return [elem] if elem is not array else return elem
    Array(params[:sort]).each_with_object({}) do |sort_by, hash|
      split = sort_by.split(",")

      raise InvalidSortError, "Sort must be in format `<field>,<direction>" unless split.length == 2

      field, direction = split
      field = field&.downcase
      direction = direction&.downcase

      raise InvalidSortError, "Sort must be in format `<field>,<direction>" if field.blank? || direction.blank?
      raise InvalidSortError, "Duplicate sort field '#{field}'" if hash.key?(field)

      hash[field] = direction
    end
  end

  class InvalidSortError < StandardError; end

  def get_page
    page = params.fetch(:page, DEFAULT_PAGE).to_i
    page = DEFAULT_PAGE if page.negative?
    page
  end

  def get_size
    size = params.fetch(:size, DEFAULT_SIZE).to_i
    size = DEFAULT_SIZE if size.negative?
    [size, MAX_SIZE].min
  end

  def get_offset
    get_page * get_size
  end

  def get_limit
    get_size
  end

  def get_pagination_record_params
    [get_offset, get_limit]
  end

  def get_pagination_params
    [get_page, get_size]
  end

  def get_pagination_metadata(records:, size:)
    record_count = records.count
    {
      total_elements: record_count,
      total_pages: (record_count.to_f / size).ceil,
    }
  end

  private

  def validate_sort_type
    query = request.query_string

    has_sort_string = query.match?(/(?:^|&)sort=/)
    has_sort_array  = query.match?(/(?:^|&)sort%5B%5D=|(?:^|&)sort\[\]=/)

    if has_sort_string && has_sort_array
      raise ActionController::BadRequest, "Invalid query parameters: cannot mix Array and String for param `sort'"
    elsif has_sort_string
      raise ActionController::BadRequest, "Invalid query parameters: expected Array (got String) for param `sort'"
    end
  end
end
