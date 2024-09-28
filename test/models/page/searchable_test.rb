require "test_helper"

class Page::SearchableTest < ActiveSupport::TestCase
  setup do
    Page.all.map &:touch # Ensure all pages are indexed
  end

  test "page body is indexed and searchable" do
    pages = Page.search("great handbook")
    assert_includes pages, pages(:welcome)
  end

  test "search results can include match snippet" do
    pages = Page.search_in("great handbook")
    assert_includes pages.first.match, "<mark>great</mark> <mark>handbook</mark>"
  end
end
