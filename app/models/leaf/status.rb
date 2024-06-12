module Leaf::Status
  extend ActiveSupport::Concern

  included do
    enum :status, %w[ draft published trashed ].index_by(&:itself), default: :draft

    scope :active, -> { where.not(status: :trashed) }
  end
end
