class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :save

  def recent_post
    posts.order(updated_at: :asc).limit(3)
  end
end

# first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
# second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

# first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
# second_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my second post')
# third_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
# fourth_post = Post.create(author: second_user, title: 'Hello again', text: 'This is my second post')
# fifth_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my third post')
