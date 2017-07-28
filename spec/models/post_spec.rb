# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end

  describe 'scopes' do
    describe '.by_created_date' do
      it 'returns the posts ordered by descending creation date' do
        old_post = create(:post)
        middle_post = create(:post)
        new_post = create(:post)
        ordered_posts = Post.by_created_date

        expect(ordered_posts.first).to eq new_post
        expect(ordered_posts.second).to eq middle_post
        expect(ordered_posts.last).to eq old_post
      end
    end

    describe '.following_and_mine' do
      it 'returns the user posts and the posts from people he/she follows' do
        user = create(:user)
        another_user = create(:user)
        user_post = create(:post, user: user)
        another_user_post = create(:post, user: another_user)
        create(:relationship, follower: user, following: another_user)

        expect(Post.following_and_mine(user)).to include(user_post, another_user_post)
      end
    end
  end
end
