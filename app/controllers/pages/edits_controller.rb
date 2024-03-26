class Pages::EditsController < ApplicationController
  before_action :set_edit

  private
    def set_edit
      @book = Book.find(params[:book_id])
      @page = Page.includes(:leaf).where(leaf: { book: @book }).find(params[:page_id])
      @edit = @page.leaf.edits.find(params[:id])
    end
end
