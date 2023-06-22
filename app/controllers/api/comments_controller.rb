class Api::CommentsController < ApplicationController
  def index
    @comments = Comment.includes(:author, :post).where(post_id: params[:post_id])
    render json: @comments
  end

  def create
    @comment = Comment.create(author_id: current_user.id, post_id: params['post_id'], text: params['text'])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment created.' }
        format.json { render json: @comment }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment not created.' }
        format.json { render json: @comment.errors }
      end
    end
  end
end
