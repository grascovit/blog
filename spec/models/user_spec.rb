# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it {
      is_expected.to have_many(:followers_relationships)
        .with_foreign_key('following_id').dependent(:destroy)
    }
    it {
      is_expected.to have_many(:following_relationships)
        .with_foreign_key('follower_id').dependent(:destroy)
    }
    it { is_expected.to have_many(:followers).through(:followers_relationships) }
    it { is_expected.to have_many(:following).through(:following_relationships) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns the first and the last name in a string' do
        user = create(:user)
        first_name = user.first_name
        last_name = user.last_name

        expect(user.full_name).to eq "#{first_name} #{last_name}"
      end
    end

    describe '#follows?' do
      context 'when user follows the params user' do
        it 'returns true' do
          follower = create(:user)
          following = create(:user)
          create(:relationship, follower: follower, following: following)

          expect(follower.follows?(following)).to eq true
        end
      end

      context 'when user does not follow the params user' do
        it 'returns false' do
          follower = create(:user)
          following = create(:user)

          expect(follower.follows?(following)).to eq false
        end
      end
    end

    describe '#posts_by_user' do
      context 'when user visits his own page' do
        it 'returns user posts and posts from people he/she follows' do
          user = create(:user)
          following = create(:user)
          create(:relationship, follower: user, following: following)
          post = create(:post, user: user)
          following_post = create(:post, user: following)

          expect(user.posts_by_user(user)).to include(post, following_post)
        end
      end

      context 'when user visits another user page' do
        it 'returns only the visited user posts' do
          user = create(:user)
          visited_user = create(:user)
          post = create(:post, user: user)
          visited_user_post = create(:post, user: visited_user)

          expect(visited_user.posts_by_user(user)).to eq([visited_user_post])
        end
      end
    end
  end

  describe 'class methods' do
    describe '.search' do
      context 'when the query param is the user first name' do
        it 'returns the user with first name Test' do
          user = create(:user, first_name: 'Test')
          another_user = create(:user, first_name: 'Another')

          expect(User.search('tes')).to include(user)
        end
      end

      context 'when the query param is the user last name' do
        it 'returns the user with last name test' do
          user = create(:user, last_name: 'Test')
          another_user = create(:user, last_name: 'Another')

          expect(User.search('tes')).to include(user)
        end
      end

      context 'when the query param is blank' do
        it 'returns all users' do
          user = create(:user, first_name: 'Test')
          another_user = create(:user, first_name: 'Another')

          expect(User.search('')).to include(user, another_user)
        end
      end
    end
  end
end
