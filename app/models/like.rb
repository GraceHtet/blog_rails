class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def like_counter_update
    post.update(likes_counter: post.likes.count)
  end
end
