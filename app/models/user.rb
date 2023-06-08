class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_default, if: :new_record?
  after_create :save

  def recent_post
    posts.order(updated_at: :asc).limit(3)
  end

  def set_default
    self.posts_counter ||= 0
  end
end
