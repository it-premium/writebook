class Books::SearchesController < ApplicationController
  include BookScoped

  def create
    @leaves = if search.present?
      @book.leaves.highlight_matches(search).favoring_title.limit(50)
    else
      Leaf.none
    end
  end

  private
    def search
      params[:search]&.gsub(/[^[:word:]"]/, " ").tap do |search|
        return nil if search.count('"').odd?
      end
    end
end
