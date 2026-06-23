class ApplicationController < ActionController::API
  DEFAULT_PAGE = 0
  DEFAULT_SIZE = 20
  MAX_SIZE = 1000

  protected

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
end
