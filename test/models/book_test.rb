require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "press a leafable" do
    leaf = books(:manual).press Page.new(title: "Introduction", body: "Important words")
    assert leaf.page?
  end
end
