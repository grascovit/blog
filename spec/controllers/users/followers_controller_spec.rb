# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FollowersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      user = create(:user)
      get :index, params: { user_id: user.id }, session: { user_id: user.id }

      expect(response).to be_success
    end
  end
end
