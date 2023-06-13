require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create name: 'Tom', photo: 'https://i.pravatar.cc/300?u=Tom', bio: 'Tom is a cool guy' }
  let!(:post) { Post.create author_id: user.id, title: 'Hello', text: 'This is my first post' }

  describe 'GET /index' do
    it 'renders a successfull response' do
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it 'get correct response status' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    it 'get correct response status' do
      get "/users/#{user.id}/posts"
      assert_equal 'index', @controller.action_name
    end

    it 'has a correct respsonse body for the existed users' do
      get "/users/#{user.id}/posts"
      assert_match 'Here is the list of posts', @response.body
    end

    it 'has a correct respsonse body if the user not exit' do
      get '/users/3/posts'
      assert_match 'There is no posts', @response.body
    end
  end

  describe 'GET /show' do
    it 'renders a successfull response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'get correct response status' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(200)
    end

    it 'get correct response status' do
      get "/users/#{user.id}/posts/#{post.id}"
      assert_equal 'show', @controller.action_name
    end

    it 'has a correct respsonse body' do
      get "/users/#{user.id}/posts/#{post.id}"

      assert_select 'h1', "Post Title: #{post.title}"
    end

    it 'has a correct respsonse body for non-existed posts' do
      get '/users/5/posts/1'
      assert_match 'There is no posts', @response.body
    end
  end
end
