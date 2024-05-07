module Book::Accesses
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
  end

  def readable?(user: Current.user)
    accesses.exists?(user: user)
  end

  def editable?(user: Current.user)
    accesses.editor.exists?(user: user)
  end

  def access_level_for(user: Current.user)
    accesses.find_by(user: user)&.level || "none"
  end
end
