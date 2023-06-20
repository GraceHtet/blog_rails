class PostsController < ApplicationController
  before_action :users_check, :posts_list
  before_action :post_check, only: [:show]

  def index
    @posts = @posts.paginate(page: params[:page],per_page: 5)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully'
    else
      render html: 'Error'
    end
  end

  private

  def users_check
    @user = User.find_by(id: params[:user_id])
  end

  def posts_list
    @posts = @user.posts.includes(:author, comments: :author)
  end

  def post_check
    @post = @user.posts.includes(comments: :author).find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end