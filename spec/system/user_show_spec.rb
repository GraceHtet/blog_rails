require 'rails_helper'

RSpec.describe 'User', type: :system do
  before(:example) do
    @tom = User.create(name: 'Tom',
                       photo: 'https://i.pravatar.cc/300?u=Tom', bio: 'I am a cat')
    @jerry = User.create(name: 'Jerry',
                         photo: 'https://i.pravatar.cc/300?u=jerry', bio: 'I am a mouse')

    @post1 = Post.create(author: @tom, title: 'Hello tom 1', text: 'This is my first post')
    @post2 = Post.create(author: @jerry, title: 'Hello2', text: 'This is my first post')
    @post3 = Post.create(author: @tom, title: 'Hello1 - tom', text: 'This is my second post')
    @post4 = Post.create(author: @jerry, title: 'Hello2 - jerry', text: 'This is my second post')
    @post5 = Post.create(author: @tom, title: 'Hello3', text: 'This is my third post')

    @comment1 = Comment.create(author: @tom, post: @post1, text: 'This is my first comment')
    @comment2 = Comment.create(author: @jerry, post: @post1, text: 'This is my second comment @post1')
    @comment3 = Comment.create(author: @tom, post: @post2, text: 'This is my first comment @post2')
    @comment4 = Comment.create(author: @tom, post: @post1, text: 'Hey , Jerry')
  end

  describe 'User visits the user#show page' do
    scenario 'I can see the users profile picture.' do
      visit user_path(@tom.id)

      assert_selector "img[src='#{@tom.photo}']"
    end

    scenario 'I can see the user username.' do
      visit user_path(@tom.id)

      assert_text @tom.name
    end

    scenario 'I can see the number of posts the user has written' do
      visit user_path(@tom.id)

      assert_text "Number of posts: #{@tom.posts_counter}"
    end

    scenario 'I can see the user bio' do
      visit user_path(@tom.id)

      assert_text @tom.bio
    end

    scenario 'I can see the users first 3 posts' do
      visit user_path(@tom)

      posts = all('.post')
      expect(posts.count).to be <= 3
      expect(posts).to all(be_visible)
    end

    scenario 'I can see a button that lets me view all of a users posts' do
      visit user_path(@tom)

      expect page.has_link?('See All Posts')
    end

    scenario 'When I click on the button, I am redirected to the user\'s posts index page' do
      visit user_path(@tom)
      click_link 'See All Posts'

      assert_current_path user_posts_path(@tom)
    end

    scenario 'When I click a user post, it redirects me to that post show page' do
      visit user_path(@tom)
      click_link @post1.title.to_s

      assert_current_path user_post_path(@tom, @post1)
    end
  end
end
