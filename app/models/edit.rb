class Edit < ApplicationRecord
  belongs_to :leaf
  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy

  enum :action, %w[ creation revision trash ].index_by(&:itself)

  scope :sorted, -> { order(created_at: :desc) }

  def current_version?
    leaf.leafable == leafable
  end

  def generate_diff(attribute)
    accumulate_diff_changes(*compare_attributes(attribute))
  end

  private
    def compare_attributes(name)
      if prior_change = find_prior_change
        [ prior_change.leafable.send(name), leafable.send(name) ]
      else
        [ "", leafable.send(name) ]
      end
    end

    def find_prior_change
      leaf.edits.where("created_at < ?", created_at).sorted.first
    end

    def accumulate_diff_changes(from, to)
      changes =  Diff::LCS.sdiff(split_words(from), split_words(to))

      changes.chunk_while { |a, b| a.action == b.action }
        .map { |chunk| [ chunk.first.action, chunk.map(&:old_element).join, chunk.map(&:new_element).join ] }
    end

    def split_words(str)
      str.split(/(\s+)/)
    end
end
