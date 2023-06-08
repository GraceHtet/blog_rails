class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_like_counter

  def update_like_counter
    post.update(likes_counter: post.likes.count)
  end
end


# Like.create(post: first_post, author: second_user).save
# Like.create(post: first_post, author: first_user).save
# Like.create(post: second_post, author: second_user).save