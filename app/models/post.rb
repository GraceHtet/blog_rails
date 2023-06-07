class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def post_counter_update
    author.update(post_counters: author.posts.count)
  end

  def recent_comment
    comments.order(updated_at: :asc).limit(5)
  end
end
