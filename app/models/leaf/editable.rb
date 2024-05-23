module Leaf::Editable
  extend ActiveSupport::Concern

  included do
    has_many :edits, dependent: :delete_all

    after_update :record_moved_to_trash, if: :was_trashed?
  end

  def edit(params)
    leaf_params = params.slice(:title)
    leafable_params = params.except(:title)

    transaction do
      new_leafable = leafable.dup_with_attachments.tap { |l| l.update!(leafable_params) }

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
