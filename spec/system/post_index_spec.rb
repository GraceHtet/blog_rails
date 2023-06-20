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

  describe 'User visits the post index page' do
    scenario 'I can see the user profile picture' do
      visit user_posts_path(@tom)

      assert_selector "img[src='#{@tom['photo']}']"
    end

    scenario 'I can see the user username' do
      visit user_posts_path(@tom)

      assert_text @tom.name
    end

    scenario 'I can see the number of posts the user has written' do
      visit user_posts_path(@tom)

      assert_text "Number of posts: #{@tom.posts_counter}"
    end

    scenario 'I can see a post title' do
      visit user_posts_path(@tom)

      assert_text @post4.title
    end

    scenario 'I can see some of the post body' do
      visit user_posts_path(@tom)

      assert_text @post3.text
    end

    scenario 'I can see the first comments on a post' do
      visit user_posts_path(@tom)

      assert_text @post3.comments.first.text
    end

    scenario 'I can see how many comments a post has' do
      visit user_posts_path(@tom)

      assert_text "Comments: #{@post3.comments_counter}"
    end

    scenario 'I can see how many likes a post has' do
      visit user_posts_path(@tom)

      assert_text "#{@tom.posts.first.likes_counter} Likes"
    end

    scenario 'I can see a section for pagination if there are more posts than fit on the view' do
      visit user_posts_path(@tom)

      assert_text '2 Next'
    end

    scenario 'When I click on a post, it redirects me to that post show page' do
      visit user_posts_path(@tom.id)
      within("#post-card-#{@post3.id}") do
        click_on @post3.title
      end
      expect(page).to have_current_path(user_post_path(@tom.id, @post3.id))
    end
  end
end
