require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:example) do
    @user = User.new(name: 'Tom',
                     photo: 'https://static.wikia.nocookie.net/tomandjerry/images/1/14/Tom_Cat_2.png/revision/latest?cb=20200412163656',
                     bio: 'I am a cat')

    @post = Post.new(author: @user, title: 'Hello', text: 'This is my first post')
  end

  subject { Like.new(author: @user, post: @post) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a post' do
      subject.post = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Update Like Counter' do
    it 'should update like counter in user' do
      subject.save
      expect(@post.likes_counter).to eq 1
    end
  end
end
