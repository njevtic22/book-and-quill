# frozen_string_literal: true

class PaginatedResponse
  attr_accessor :data

  def initialize(total_elements:, total_pages:, data:)
    @total_elements = total_elements
    @total_pages = total_pages
    @data = data
  end

  def as_json(*)
    {
      total_elements: @total_elements,
      total_pages: @total_pages,
      data: @data
    }
  end
end
