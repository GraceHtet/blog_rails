require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { User.create name: 'Tom', photo: 'https://i.pravatar.cc/300?u=Tom', bio: 'Tom is a cool guy' }
  describe 'GET /index' do
    it 'renders a successfull response' do
      get users_path
      expect(response).to be_successful
    end

    it 'get correct response status' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'get correct response status' do
      get users_path
      assert_equal 'index', @controller.action_name
    end

    it 'has a correct respsonse body' do
      get users_path
      assert_match 'Here is where you can see a list of users', @response.body
    end
  end

  describe 'GET /show' do
    it 'renders a successfull response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'get correct response status' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end

    it 'get correct response status' do
      get "/users/#{user.id}"
      assert_equal 'show', @controller.action_name
    end

    it 'has a correct respsonse body' do
      get "/users/#{user.id}"

      assert_select 'h1', "User id: #{user.id}"
      assert_select 'h2', "User name: #{user.name}"
      assert_select 'p', "Bio: #{user.bio}"
    end

    it 'has a correct respsonse body for non-existed users' do
      get '/users/5'
      assert_match 'User not found', @response.body
    end
  end
end
