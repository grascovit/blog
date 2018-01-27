# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end

  let(:invalid_attributes) do
    {
      session: {
        email: 'invalid@email.com',
        password: 'invalid'
      }
    }
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_session_path

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'stores user id in the session' do
        post sessions_path, params: valid_attributes

        expect(session[:user_id]).to eq user.id
      end

      it 'redirects to the user path' do
        post sessions_path, params: valid_attributes

        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'with invalid params' do
      it 'does not store the user id in session' do
        post sessions_path, params: invalid_attributes

        expect(session[:user_id]).to eq nil
      end

      it 'displays a flash alert' do
        post sessions_path, params: invalid_attributes

        expect(flash[:alert]).to eq I18n.t('controllers.session.bad_credentials')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'deletes user id from session store' do
        post sessions_path, params: valid_attributes
        delete session_path

        expect(session[:user_id]).to eq nil
      end

      it 'redirects to the root path' do
        post sessions_path, params: valid_attributes
        delete session_path

        expect(response).to redirect_to(root_url)
      end
    end

    context 'when user is not logged in' do
      it 'displays a flash alert' do
        delete session_path

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end
end
