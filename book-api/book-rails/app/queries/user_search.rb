# frozen_string_literal: true

class UserSearch
  FILTERABLE_FIELDS = %w[name surname email username role].freeze
  SORTABLE_FIELDS = %w[id name surname email username role].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze

  def self.build(records, params)
    records = filter(records, params)
    sort(records, params[:sort])
  end

  private_class_method def self.filter(records, params)
    FILTERABLE_FIELDS.each do |field|
      next unless params[field].present?

      records = records.where("#{field} ILIKE ?", "%#{params[field]}%")
    end
    records
  end

  private_class_method def self.sort(records, sort_raw)
    return records.order(id: :asc) if sort_raw.blank?

    sort_by = parse_sort(sort_raw)
    records.order(sort_by)
  end

  # TODO: move validation to ApplicationController
  private_class_method def self.parse_sort(sort_raw)
    # Array(elem) return [elem] if elem is not array else return elem
    Array(sort_raw).each_with_object({}) do |sort_by, hash|
      field, direction, extra = sort_by.to_s.split(",")
      field = field&.downcase
      direction = direction&.downcase

      raise InvalidSortError, "Sort must be in format `<field>,<direction>" if field.blank? || direction.blank? || extra
      raise InvalidSortError, "invalid sort field '#{field}'" unless SORTABLE_FIELDS.include?(field)
      raise InvalidSortError, "Invalid sort direction '#{direction}'" unless SORT_DIRECTIONS.include?(direction)
      raise InvalidSortError, "Duplicate sort field '#{field}'" if hash.key?(field)

      hash[field] = direction
    end
  end

  class InvalidSortError < StandardError; end
end
