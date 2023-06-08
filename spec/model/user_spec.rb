require 'rails_helper'

RSpec.describe User, type: :model do
    subject{ User.new(name: 'Tom', photo: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fcat%2F&psig=AOvVaw0QZ2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4&ust=1623178440008000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJjQ9ZqH0_ECFQAAAAAdAAAAABAD', bio: 'I am a cat')}

    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end

    it 'is not valid without a name' do
        subject.name = nil
        expect(subject).to_not be_valid
    end
    
    it 'is not valid without valid post counter' do
        subject.posts_counter = -1
        expect(subject).to_not be_valid
    end

    it 'default post_counter should be 0' do
        expect(subject.posts_counter).to be 0
    end

    it 'should have only three recent posts' do
        Post.create(author: subject, title: 'Hello', text: 'This is my first post')
        Post.create(author: subject, title: 'Hello again', text: 'This is my second post')
        Post.create(author: subject, title: 'Hello', text: 'This is my third post')
        Post.create(author: subject, title: 'Hello again', text: 'This is my lasst post')

        expect(subject.recent_post.length).to be 3
    end

    it 'should have only three recent posts' do
        first_post = Post.create(author: subject, title: 'Hello', text: 'This is my first post',created_at: "2023-06-06 12:42:57.332457000 +0000", updated_at: "2023-06-06 12:42:57.332457000 +0000")
        Post.create(author: subject, title: 'Hello again', text: 'This is my second post')
        Post.create(author: subject, title: 'Hello', text: 'This is my third post')
        last_post = Post.create(author: subject, title: 'Hello again', text: 'This is my last post')

        expect(subject.recent_post).to_not include first_post
    end
end