require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://static.wikia.nocookie.net/tomandjerry/images/1/14/Tom_Cat_2.png/revision/latest?cb=20200412163656', bio: 'I am a cat') }

  before(:example) do
    @first_post = Post.create(author: subject, title: 'Hello', text: 'This is my first post',
                              created_at: '2023-06-06 12:42:57.332457000', updated_at: '2023-06-06 12:42:57.332457000')
    Post.create(author: subject, title: 'Hello again', text: 'This is my second post')
    Post.create(author: subject, title: 'Hello', text: 'This is my third post')
    @last_post = Post.create(author: subject, title: 'Hello again', text: 'This is my last post')
  end

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

  it 'should have only three posts' do
    expect(subject.recent_post.length).to be 3
  end

  it 'should have only three recent posts' do
    expect(subject.recent_post).to_not include @first_post
  end
end
