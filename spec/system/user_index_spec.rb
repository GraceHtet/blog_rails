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

  describe 'User visits the index page' do
    scenario 'I can see the username of all other users' do
      visit users_path
      expect(page).to have_content 'List of Users'
      expect(page).to have_content(@tom.name)
      expect(page).to have_content(@jerry.name)
    end

    scenario 'I can see the profile picture for each user' do
      visit users_path

      expect(page).to have_selector("img[src='#{@tom['photo']}']")
      expect(page).to have_selector("img[src='#{@jerry['photo']}']")
    end

    scenario 'I can see the number of posts each user has written.' do
      visit users_path

      expect(page).to have_content "Number of posts: #{@tom.posts_counter}"
      expect(page).to have_content "Number of posts: #{@jerry.posts_counter}"
    end

    scenario 'When I click on a user, I am redirected to that user show page.' do
      visit users_path
      click_on 'Tom'
      expect(current_path).to eq(user_path(@tom.id))
    end
  end
end
