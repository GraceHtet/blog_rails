class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def comment_counter_update
    post.update(comments_counter: post.comments.count)
  end
end

# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' ).comment_counter_update
# Comment.create(post: first_post, author: second_user, text: 'Long Time no see!' ).comment_counter_update
# Comment.create(post: first_post, author: second_user, text: 'WHUB!' ).comment_counter_update
# Comment.create(post: first_post, author: second_user, text: 'Hey' ).comment_counter_update
# Comment.create(post: first_post, author: second_user, text: 'Yeah, Been a while' ).comment_counter_update
# Comment.create(post: first_post, author: second_user, text: 'I am just stay silent in social media' ).comment_counter_update
