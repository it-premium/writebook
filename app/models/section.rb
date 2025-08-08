class Section < ApplicationRecord
  include Leafable

  def markdown_content
    "# #{body}"
  end

  def searchable_content
    body
  end
end
