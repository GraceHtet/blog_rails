class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if user_signed_in?
      @user = User.includes(:posts, :comments, :likes).find_by(id: params[:id])


      return unless @user.present?

      render html: 'User not found', status: :not_found
    else
      redirect_to root_path, notice: 'You are not signed in.'
    end
  end
end
