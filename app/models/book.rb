class Book < ApplicationRecord
  has_many :leafs, dependent: :destroy

  scope :ordered, -> { order(:title) }

  def press(leafable, parent: nil)
    transaction do
      leafable.save!
      leafs.create! leafable: leafable, parent: parent
    end
  end
end
