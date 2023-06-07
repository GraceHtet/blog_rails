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

# first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
# second_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my second post')
# third_post = Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
# fourth_post = Post.create(author: second_user, title: 'Hello again', text: 'This is my second post')
# fifth_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my third post')
