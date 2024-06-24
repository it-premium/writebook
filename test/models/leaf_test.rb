require "test_helper"

class LeafTest < ActiveSupport::TestCase
  test "slug is generated from title" do
    leaf = Leaf.new(title: "Hello, World!")
    assert_equal "hello-world", leaf.slug
  end
end
