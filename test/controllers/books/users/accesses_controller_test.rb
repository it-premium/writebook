require "test_helper"

class Books::Users::AccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :david
  end

  test "create sets the access level" do
    post book_user_access_url(books(:handbook), users(:kevin)), params: { level: "editor" }

    assert_response :success
    assert books(:handbook).editable?(user: users(:kevin))
  end

  test "destroy clears access levels" do
    delete book_user_access_url(books(:handbook), users(:kevin))

    assert_response :success
    assert_not books(:handbook).editable?(user: users(:kevin))
    assert_not books(:handbook).readable?(user: users(:kevin))
  end
end
