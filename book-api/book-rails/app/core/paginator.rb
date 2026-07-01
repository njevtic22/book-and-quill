# frozen_string_literal: true

class Paginator
  def self.paginate(page, size, records)
    record_count = records.count
    PaginatedResponse.new(
      total_elements: record_count,
      total_pages: (record_count.to_f / size).ceil,
      data: records.offset(page * size).limit(size)
    )
  end
end
