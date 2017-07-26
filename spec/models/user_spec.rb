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
  end
end
