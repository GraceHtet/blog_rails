class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :save
  after_save :update_like_counter

  def update_like_counter
    post.update(likes_counter: post.likes.count)
  end
end
