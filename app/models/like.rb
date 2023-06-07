class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def like_counter_update
    post.update(likes_counter: post.likes.count)
  end
end

# Comment.create(post: first_post, author: second_user).like_counter_update
# Comment.create(post: first_post, author: first_user).like_counter_update
# Comment.create(post: second_post, author: second_user).like_counter_update
