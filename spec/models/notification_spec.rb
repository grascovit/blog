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
end
