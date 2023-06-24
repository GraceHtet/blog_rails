require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
    describe 'Posts API' do
        path '/api/posts' do
            get 'list all posts for a user' do
                tags 'Posts'
                produces 'application/json'
                parameter name: :user_id, in: :query, type: :integer

                response '200', 'posts found' do
                    schema type: :object,
                      properties: {
                        id: { type: :integer, },
                        author_id: { type: :integer },
                        name: { type: :string },
                        photo_url: { type: :string },
                        text: { type: :string },
                        created_at: { type: :string, format: :date_time },
                        updated_at: { type: :string, format: :date_time }
                      },
                      required: [ 'id', 'title']
            
                    let(:user_id) { User.create(name: 'foo').id }
                    run_test!
                  end
            end
        end
    end
end
