# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesHelper, type: :helper do
  describe '#home_link' do
    context 'when user is logged in' do
      it 'returns the user path' do
        user = create(:user)
        @current_user = user

        expect(helper.home_link).to eq(user_path(user))
      end
    end

    context 'when user is not logged in' do
      it 'returns the root path' do
        expect(helper.home_link).to eq(root_path)
      end
    end
  end
end
