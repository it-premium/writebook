require "test_helper"

class Leaf::EditableTest < ActiveSupport::TestCase
  test "editing a leafable records the edit" do
    leaves(:welcome_page).edit leafable_params: { body: "New body" }

    assert_equal "New body", leaves(:welcome_page).page.body.content

    assert leaves(:welcome_page).edits.last.revision?
    assert_equal "This is _such_ a great handbook.", leaves(:welcome_page).edits.last.page.body.content
  end

  test "editing a leafable with an attachment includes the attachments in the new version" do
    assert leaves(:reading_picture).picture.image.attached?

    leaves(:reading_picture).edit leaf_params: { title: "New title" }

    assert_equal "New title", leaves(:reading_picture).title
    assert leaves(:reading_picture).picture.image.attached?
  end

  test "trashing a leaf records the edit" do
    leaves(:welcome_page).trashed!

    assert leaves(:welcome_page).trashed?

    assert leaves(:welcome_page).edits.last.trash?
    assert_equal "This is _such_ a great handbook.", leaves(:welcome_page).edits.last.page.body.content
  end
end
