# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:following).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:follower_id) }
    it { is_expected.to validate_presence_of(:following_id) }
  end

  describe 'callbacks' do
    describe '#create_notification' do
      it 'creates a notification' do
        follower = create(:user)
        following = create(:user)

        expect do
          create(:relationship, follower: follower, following: following)
        end.to change(Notification, :count).by(1)
      end
    end
  end
end
