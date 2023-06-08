require 'rails_helper'

RSpec.describe Post, type: :model do
    before(:example) do
        @user = User.new(name: 'Tom', photo: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fcat%2F&psig=AOvVaw0QZ2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4Z2Z4&ust=1623178440008000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJjQ9ZqH0_ECFQAAAAAdAAAAABAD', bio: 'I am a cat')
    end

    subject{ Post.new(author: @user, title: 'Hello', text: 'This is my first post')}

    describe 'validations' do
        it 'is valid with valid attributes' do
            expect(subject).to be_valid
        end
    
        it 'is not valid without an author' do
            subject.author = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a title' do
            subject.title = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid if title is blank' do
            subject.title = ""
            expect(subject).to_not be_valid
        end

        it 'is not valid if title is longer than 250 words' do
            subject.title = 'A' * 251
            expect(subject).to_not be_valid
        end
        
        it 'is not valid without valid comment counter' do
            subject.comments_counter = -1
            expect(subject).to_not be_valid
        end
    
        it 'default comment_counter should be 0' do
            expect(subject.comments_counter).to be 0
        end

        it 'is not valid without valid like counter' do
            subject.likes_counter = -1
            expect(subject).to_not be_valid
        end
    
        it 'default like_counter should be 0' do
            expect(subject.likes_counter).to be 0
        end
    end

    describe 'Update Post Counter' do
        it 'should update post counter in user' do
            subject.save
            expect(@user.posts_counter).to eq 1
        end
    end

    describe 'Recent Comment' do
        it 'should have only 5 comments' do
            first_comment = Comment.create(post: subject, author: @user, text: 'Hi Tom!' )
            Comment.create(post: subject, author: @user, text: 'Long Time no see!' )
            Comment.create(post: subject, author: @user, text: 'WHUB!' )
            Comment.create(post: subject, author: @user, text: 'Hey' )
            Comment.create(post: subject, author: @user, text: 'Yeah, Been a while' )
            sixth_comment = Comment.create(post: subject, author: @user, text: 'I am just stay silent in social media' )

            expect(subject.recent_comment.length).to be 5
        end

        it 'should have only 5 recent comments' do
            first_comment = Comment.create(post: subject, author: @user, text: 'Hi Tom!' )
            Comment.create(post: subject, author: @user, text: 'Long Time no see!' )
            Comment.create(post: subject, author: @user, text: 'WHUB!' )
            Comment.create(post: subject, author: @user, text: 'Hey' )
            Comment.create(post: subject, author: @user, text: 'Yeah, Been a while' )
            sixth_comment = Comment.create(post: subject, author: @user, text: 'I am just stay silent in social media' )

            expect(subject.recent_comment).to_not include first_comment
        end
    end
end