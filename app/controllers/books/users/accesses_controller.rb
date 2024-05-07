class Books::Users::AccessesController < ApplicationController
  include BookScoped

  before_action :set_user

  def create
    @book.accesses.find_or_initialize_by(user: @user).update!(level: params[:level])
  end

  def destroy
    @book.accesses.destroy_by(user: @user)
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
