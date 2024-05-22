require "test_helper"

class Leaf::EditableTest < ActiveSupport::TestCase
  test "editing a leafable records the edit" do
    leaves(:welcome_page).edit(title: "New title")

    assert_equal "New title", leaves(:welcome_page).title

    assert leaves(:welcome_page).edits.last.revision?
    assert_equal "Welcome to The Handbook!", leaves(:welcome_page).edits.last.page.title
  end

  test "trashing a leaf records the edit" do
    leaves(:welcome_page).trashed!

    assert leaves(:welcome_page).trashed?

    assert leaves(:welcome_page).edits.last.trash?
    assert_equal "Welcome to The Handbook!", leaves(:welcome_page).edits.last.page.title
  end
end
