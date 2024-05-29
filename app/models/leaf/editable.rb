module Leaf::Editable
  extend ActiveSupport::Concern

  included do
    has_many :edits, dependent: :delete_all

    after_update :record_moved_to_trash, if: :was_trashed?
  end

  def edit(leafable_params: {}, leaf_params: {})
    transaction do
      new_leafable = leafable.dup_with_attachments
      new_leafable.assign_attributes leafable_params
      new_leafable.save!

      edits.revision.create!(leafable: leafable)
      update! leaf_params.merge(leafable: new_leafable)
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
