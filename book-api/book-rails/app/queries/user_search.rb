# frozen_string_literal: true

class UserSearch
  FILTERABLE_FIELDS = %w[name surname email username role].freeze
  SORTABLE_FIELDS = %w[id name surname email username role].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze

  def self.build(records, params, sort_by)
    records = filter(records, params)
    sort(records, sort_by)
  end

  private_class_method def self.filter(records, params)
    FILTERABLE_FIELDS.each do |field|
      next unless params[field].present?

      records = records.where("#{field} ILIKE ?", "%#{params[field]}%")
    end
    records
  end

  private_class_method def self.sort(records, sort_by)
    return records.order(id: :asc) if sort_by.empty?

    sort_by.each do |field, direction|
      raise InvalidSortError, "invalid sort field '#{field}'" unless SORTABLE_FIELDS.include?(field)
      raise InvalidSortError, "Invalid sort direction '#{direction}'" unless SORT_DIRECTIONS.include?(direction)
    end

    records.order(sort_by)
  end


  # TODO: duplicated error in ApplicationController
  # fix: create separate class InvalidSortException in app/core/error/exceptions
  class InvalidSortError < StandardError; end
end
