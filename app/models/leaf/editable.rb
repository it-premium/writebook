module Leaf::Editable
  extend ActiveSupport::Concern

  included do
    has_many :edits, dependent: :delete_all

    after_update :record_moved_to_trash, if: :was_trashed?
  end

  def edit(leafable_params)
    transaction do
      edits.revision.create!(leafable: leafable)

      new_leafable = leafable.dup.tap { |l| l.update!(leafable_params) }
      # TODO: can we see if the update actually changed something, and skip creating the edit if not?
      update!(leafable: new_leafable)
    end
  end

  private
    def record_moved_to_trash
      edits.trash.create!(leafable: leafable)
    end

    def was_trashed?
      trashed? && previous_changes.include?(:status)
    end
end
