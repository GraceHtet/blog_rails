class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def comment_counter_update
    post.update(comments_counter: post.comments.count)
  end
end
