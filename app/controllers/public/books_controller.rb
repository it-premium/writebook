module Public
  class BooksController < BaseController
    def show
      @book = Book.published.find_by! slug: params[:slug]
      @leaves = @book.leaves.active.with_leafables.positioned
    end
  end
end
