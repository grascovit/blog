# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      user = create(:user)
      get :index, session: { user_id: user.id }

      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    context 'when user visits his/her own page' do
      it 'returns a success response' do
        user = create(:user)
        get :show,
            params: { id: user.to_param },
            session: { user_id: user.id }

        expect(response).to be_success
      end
    end

    context 'when user visits another user page' do
      it 'returns a success response' do
        user = create(:user)
        get :show,
            params: { id: user.to_param }

        expect(response).to be_success
      end
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new

      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      user = create(:user)
      get :edit,
          params: { id: user.to_param },
          session: { user_id: user.id }

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }

        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: invalid_attributes }
        end.not_to change(User, :count)
      end

      it 'returns a success response' do
        post :create, params: { user: invalid_attributes }

        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:user)
      end

      it 'updates the current user' do
        put :update,
            params: { id: user.to_param, user: new_attributes },
            session: { user_id: user.id }
        user.reload

        expect(user.email).to eq(new_attributes[:email])
      end

      it 'redirects to the user' do
        put :update,
            params: { id: user.to_param, user: new_attributes },
            session: { user_id: user.id }

        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'does not update the user' do
        put :update,
            params: { id: user.to_param, user: invalid_attributes },
            session: { user_id: user.id }
        old_email = user.email
        user.reload

        expect(user.email).to eq(old_email)
      end

      it 'displays a flash alert' do
        put :update, params: { id: user.to_param, user: invalid_attributes }

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'destroys the current user' do
        user = create(:user)

        expect do
          delete :destroy,
                 params: { id: user.to_param },
                 session: { user_id: user.id }
        end.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        user = create(:user)
        delete :destroy,
               params: { id: user.to_param },
               session: { user_id: user.id }

        expect(response).to redirect_to(users_url)
      end
    end

    context 'when user is not logged in' do
      it 'does not destroy the user' do
        user = create(:user)

        expect do
          delete :destroy, params: { id: user.to_param }
        end.not_to change(User, :count)
      end

      it 'displays a flash alert' do
        user = create(:user)
        delete :destroy, params: { id: user.to_param }

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end

  describe 'GET #followers' do
    it 'returns a success response' do
      user = create(:user)
      get :followers, params: { user_id: user.id }, session: { user_id: user.id }

      expect(response).to be_success
    end
  end

  describe 'GET #following' do
    it 'returns a success response' do
      user = create(:user)
      get :following, params: { user_id: user.id }, session: { user_id: user.id }

      expect(response).to be_success
    end
  end

  describe 'GET #search' do
    it 'returns a success response' do
      user = create(:user)
      get :search, params: { query: user.username }, session: { user_id: user.id }

      expect(response).to be_success
    end
  end
end
