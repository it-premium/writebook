module Book::Sluggable
  extend ActiveSupport::Concern

  included do
    after_save :generate_slug, if: -> { slug.blank? && just_published? }
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
