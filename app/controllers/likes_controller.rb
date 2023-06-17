class LikesController < ApplicationController
  def create
    @like = Like.create(author_id: current_user.id, post_id: params[:post_id])

    redirect_to user_posts_path(params[:user_id]) if @like.save
  end
end
