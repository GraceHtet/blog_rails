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

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(author_id: current_user.id, title: params['post']['title'], text: params['post']['text'])

    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render html: 'Error'
    end
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
