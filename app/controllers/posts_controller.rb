class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])

    return unless @post.nil?

    render html: 'Post not found', status: :not_found
  end
end
