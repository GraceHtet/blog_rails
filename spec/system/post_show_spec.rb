require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before(:example) do
    @tom = User.create(name: 'Tom',
                       photo: 'https://i.pravatar.cc/300?u=Tom', bio: 'I am a cat')
    @jerry = User.create(name: 'Jerry',
                         photo: 'https://i.pravatar.cc/300?u=jerry', bio: 'I am a mouse')

    @post1 = Post.create(author: @tom, title: 'Hello tom 1', text: 'This is my first post')
    @post2 = Post.create(author: @jerry, title: 'Hello2', text: 'This is my first post')
    @post3 = Post.create(author: @tom, title: 'Hello1 - tom', text: 'This is my second post')
    @post4 = Post.create(author: @tom, title: 'Hello2 - tom', text: 'This is my second post')
    @post5 = Post.create(author: @tom, title: 'Hello3', text: 'This is my third post')
    @post6 = Post.create(author: @tom, title: '4Hello', text: 'This is my second post')
    @post7 = Post.create(author: @tom, title: '5Hello', text: 'This should be in the next page')

    @comment1 = Comment.create(author: @tom, post: @post3, text: 'This is my first comment')
    @comment2 = Comment.create(author: @jerry, post: @post1, text: 'This is my second comment @post1')
    @comment3 = Comment.create(author: @tom, post: @post1, text: 'This is my first comment @post1')
    @comment4 = Comment.create(author: @jerry, post: @post1, text: 'Hey , tom')
  end

  describe 'User visits the post show page' do
    scenario 'I can see a post title' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text @tom.posts.first.title
    end

    scenario 'I can see who wrote the post' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text "#{@tom.posts.first.title} by #{@tom.name}"
    end

    scenario 'I can see how many comments a post has' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text "Comments: #{@tom.posts.first.comments_counter}"
    end

    scenario 'I can see how many likes a post has' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text "#{@tom.posts.first.likes_counter} Likes"
    end

    scenario 'I can see the post body' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text @tom.posts.first.text
    end

    scenario 'I can see the username of each commentor and the comment each commentor left.' do
      visit user_post_path(@tom, @tom.posts.first)

      assert_text "#{@tom.posts.first.comments.first.author.name}:#{@tom.posts.first.comments.first.text}"
    end
  end
end
