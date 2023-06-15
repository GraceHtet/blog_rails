class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    return unless @user.nil?

    render html: 'User not found', status: :not_found

    
  end
end
