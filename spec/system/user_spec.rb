require 'rails_helper'

RSpec.describe 'User', type: :system do
  before(:example) do
    @tom = User.create(name: 'Tom',
                       photo: 'https://static.wikia.nocookie.net/tomandjerry/images/1/14/Tom_Cat_2.png/revision/latest?cb=20200412163656', bio: 'I am a cat')
    @jerry = User.create(name: 'Jerry',
                         photo: 'https://static.wikia.nocookie.net/tomandjerry/images/1/14/Jerry_Mouse_2.png/revision/latest?cb=20200412163656', bio: 'I am a mouse')

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
