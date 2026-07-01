# frozen_string_literal: true

class UserSearch
  FILTERABLE_FIELDS = %w[name surname email username role].freeze
  SORTABLE_FIELDS = %w[id name surname email username role].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze

  def self.build(records, params)
    records = filter(records, params)
    sort(records, params[:sort])
  end

  private

  def self.filter(records, params)
    FILTERABLE_FIELDS.each do |field|
      next unless params[field].present?

      records = records.where("#{field} ILIKE ?", "%#{params[field]}%")
    end
    records
  end

  def self.sort(records, sort_by)
    return records.order(id: :asc) if sort_by.blank?

    field, direction, extra = sort_by.to_s.split(",")
    field = field&.downcase
    direction = direction&.downcase

    # TODO: move validation to ApplicationController
    raise InvalidSortError, "Sort must be in format `<field>,<direction>" if field.blank? || direction.blank? || extra
    raise InvalidSortError, "invalid sort field '#{field}'" unless SORTABLE_FIELDS.include?(field)
    raise InvalidSortError, "Invalid sort direction '#{direction}'" unless SORT_DIRECTIONS.include?(direction)

    records.order(field => direction)
  end

  class InvalidSortError < StandardError; end
end
