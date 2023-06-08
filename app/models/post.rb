class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  
  validates :title, presence: true, length: { maximum: 250}
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_default, if: :new_record?
  after_create :save
  after_save :update_post_counter

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comment
    comments.order(updated_at: :asc).limit(5)
  end

  def set_default
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
