class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id
    has_many :comments, foreign_key: :author_id
    has_many :likes, foreign_key: :author_id

    def recent_post
        posts.order(updated_at: :asc).limit(3)
    end
end

# first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
# second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
