class PostsController < ApplicationController
  def index
    users_check
    posts_list
  end

  def show
    users_check
    posts_list
    post_check
  end

  private

  def users_check
    @user = User.find_by(id: params[:user_id])
  end

  def posts_list
    @posts = @user.posts unless @user.nil?
  end

  def post_check
    @post = @posts.find_by(id: params[:id]) unless @posts.nil?
  end
end
