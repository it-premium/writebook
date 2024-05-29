class SectionsController < ApplicationController
  include SetBookLeaf

  def new
    @section = Section.new
  end

  def create
    @leafable = new_section
    @book.leaves.create! leaf_params.merge(leafable: @leafable)

    respond_to do |format|
      format.turbo_stream { render }
      format.html { redirect_to @book }
    end
  end

  def show
  end

  def edit
  end

  def update
    @leaf.edit leaf_params: leaf_params

    respond_to do |format|
      format.turbo_stream { render }
      format.html { redirect_to leafable_url(@leaf) }
    end
  end

  def destroy
    @leaf.trashed!
    redirect_to @book
  end

  private
    def new_section
      Section.new
    end

    def leaf_params
      params.require(:section).permit(:title)
    end
end
