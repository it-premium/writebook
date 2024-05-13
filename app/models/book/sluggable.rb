module Book::Sluggable
  extend ActiveSupport::Concern

  included do
    after_save :generate_slug, if: -> { slug.blank? && just_published? }
    validates :slug, uniqueness: true, if: -> { slug.present? }
  end

  def generate_slug
    update! slug: title.parameterize
  rescue ActiveRecord::RecordNotUnique
    update! slug: "#{title.parameterize}-#{SecureRandom.hex(4)}"
  end

  def just_published?
    saved_change_to_published? && published?
  end
end
