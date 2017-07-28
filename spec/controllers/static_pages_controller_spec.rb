# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    context 'when user is logged in' do
      it 'redirects to the user page' do
        user = create(:user)
        get :home, session: { user_id: user.id }

        expect(response).to redirect_to user_path(user)
      end  
    end

    context 'when user is not logged in' do
      it 'renders the home page' do
        get :home

        expect(response).to have_http_status(:success)
      end
    end
  end
end
