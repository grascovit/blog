# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'Authenticable' do
    let(:user) { create(:user) }

    controller do
      def index; end
    end

    describe '#authenticate_user' do
      context 'when user is logged in' do
        it 'returns the valid user' do
          session[:user_id] = user.id

          expect(controller.authenticate_user).to eq(user)
        end
      end

      context 'when user is not logged in' do
        it 'displays a flash alert' do
          get :index # fake action call

          expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
        end

        it 'redirects to the login page' do
          get :index # fake action call

          expect(response).to redirect_to(new_session_path)
        end
      end
    end

    describe '#current_user' do
      context 'when there is a user id in the session' do
        it 'returns the current user' do
          session[:user_id] = user.id

          expect(controller.current_user).to eq(user)
        end
      end

      context 'when there is not a user id in the session' do
        it 'returns nil' do
          expect(controller.current_user).to eq(nil)
        end
      end
    end

    describe '#user_signed_in?' do
      context 'when user is logged in' do
        it 'returns true' do
          session[:user_id] = user.id

          expect(controller.user_signed_in?).to eq true
        end
      end

      context 'when user is not logged in' do
        it 'returns false' do
          expect(controller.user_signed_in?).to eq false
        end
      end
    end
  end
end
