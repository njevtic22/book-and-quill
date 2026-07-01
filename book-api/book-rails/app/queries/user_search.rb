# frozen_string_literal: true

class UserSearch
  FILTERABLE_FIELDS = %w[name surname email username role].freeze

  def self.build(fetch_relation, params)
    fetch_relation = filter(fetch_relation, params)
    fetch_relation
  end

  private

  def self.filter(relation, params)
    FILTERABLE_FIELDS.each do |field|
      next unless params[field].present?

      relation = relation.where("#{field} ILIKE ?", "%#{params[field]}%")
    end

    relation
  end

  def sort(fetch_relation, params)
    # TODO
  end
end
