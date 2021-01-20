module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = ['public', 'private', 'archived']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
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
    status == 'archived'
  end

  def public?
    status == 'public'
  end

  def private?
    status == 'private'
  end
end
