require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    get new_book_page_path(books(:handbook))
    assert_response :ok

    post book_pages_path(books(:handbook)), params: { page: { title: "Another page", body: "With interesting words." } }
    assert_redirected_to books(:handbook)

    new_page = Page.last
    assert_equal "Another page", new_page.title
    assert_equal "With interesting words.", new_page.body
    assert_equal books(:handbook), new_page.leaf.book
  end
end
