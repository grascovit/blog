require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#home_link' do
    context 'when user is logged in' do
      it 'returns the user path' do
        user = UserDecorator.new(create(:user))

        expect(user.home_link).to eq(h.user_path(user))
      end
    end

    context 'when user is not logged in' do
      it 'returns the root path' do
        user = UserDecorator.new(nil)

        expect(user.home_link).to eq(h.root_path)
      end
    end
  end
end
