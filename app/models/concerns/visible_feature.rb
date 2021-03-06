module VisibleFeature
  extend ActiveSupport::Concern
  PUBLIC = 'public'.freeze
  PERSONAL = 'personal'.freeze
  ARCHIVED = 'archived'.freeze

  # Valid statuses have capitalized symbol-keys to facilitate the capitalized
  # rendering of the statuses names within the views.
  VALID_STATUSES = { Public: PUBLIC, Personal: PERSONAL, Archived: ARCHIVED }.freeze

  included do
    validates :status, inclusion: { in: VALID_STATUSES.values }
  end

  class_methods do

    # Count how many elements have the status passed as parameter
    def count_status(status)
      where(status: status).count
    end

    # Count how many elements does not have the status passed as parameter
    def count_without_status(status)
      where.not(status: status).count
    end

  end

  def archived?
    status == ARCHIVED
  end

  def public?
    status == PUBLIC
  end

  def personal?
    status == PERSONAL
  end
end
