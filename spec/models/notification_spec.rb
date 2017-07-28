# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_presence_of(:action) }
  end

  describe 'instance methods' do
    describe '#read?' do
      context 'when notification has been read' do
        it 'returns true' do
          notification = create(:notification, read_at: Time.current)

          expect(notification.read?).to eq true
        end
      end

      context 'when notification has not been read yet' do
        it 'returns false' do
          notification = create(:notification)

          expect(notification.read?).to eq false
        end
      end
    end
  end

  describe 'scopes' do
    describe '.by_created_date' do
      it 'returns the posts ordered by descending creation date' do
        old_notification = create(:notification)
        middle_notification = create(:notification)
        new_notification = create(:notification)
        ordered_notification = Notification.by_created_date

        expect(ordered_notification.first).to eq new_notification
        expect(ordered_notification.second).to eq middle_notification
        expect(ordered_notification.last).to eq old_notification
      end
    end
  end
end
