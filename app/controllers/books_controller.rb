class BooksController < ApplicationController
  def index
    @books = Book.ordered
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create! book_params
    redirect_to book
  end

  def show
    @leafs = @book.leafs.roots.with_leafables
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end
end
