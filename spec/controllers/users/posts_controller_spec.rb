# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PostsController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:post)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_post)
  end

  describe 'GET #show' do
    it 'returns a success response' do
      post = create(:post)
      get :show,
          params: { id: post.to_param, user_id: post.user.id },
          session: { user_id: post.user.id }

      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      post = create(:post)
      get :edit,
          params: { id: post.to_param, user_id: post.user.id },
          session: { user_id: post.user.id }

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid params' do
      it 'creates a new post' do
        expect do
          post :create,
               params: { post: valid_attributes, user_id: user.id },
               session: { user_id: user.id }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the current user' do
        post :create,
             params: { post: valid_attributes, user_id: user.id },
             session: { user_id: user.id }

        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'does not create a new post' do
        expect do
          post :create,
               params: { post: invalid_attributes, user_id: user.id },
               session: { user_id: user.id }
        end.not_to change(Post, :count)
      end

      it 'redirects to the current user' do
        post :create,
             params: { post: invalid_attributes, user_id: user.id },
             session: { user_id: user.id }

        expect(response).to redirect_to(user)
      end
    end
  end

  describe 'PUT #update' do
    let(:post) { create(:post) }

    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:post)
      end

      it 'updates the requested post' do
        put :update,
            params: { id: post.to_param, user_id: post.user.id, post: new_attributes },
            session: { user_id: post.user.id }
        post.reload

        expect(post.message).to eq(new_attributes[:message])
      end

      it 'redirects to the current user' do
        put :update,
            params: { id: post.to_param, user_id: post.user.id, post: new_attributes },
            session: { user_id: post.user.id }

        expect(response).to redirect_to(post.user)
      end
    end

    context 'with invalid params' do
      it 'does not update the post' do
        old_message = post.message
        put :update,
            params: { id: post.to_param, user_id: post.user.id, post: invalid_attributes },
            session: { user_id: post.user.id }
        post.reload

        expect(post.message).to eq(old_message)
      end

      it 'displays a flash alert' do
        put :update,
            params: { id: post.to_param, user_id: post.user.id, post: invalid_attributes }

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'destroys the requested post' do
        post = create(:post)

        expect do
          delete :destroy,
                 params: { id: post.to_param, user_id: post.user.id },
                 session: { user_id: post.user.id }
        end.to change(Post, :count).by(-1)
      end

      it 'redirects to the current user' do
        post = create(:post)
        delete :destroy,
               params: { id: post.to_param, user_id: post.user.id },
               session: { user_id: post.user.id }

        expect(response).to redirect_to(post.user)
      end
    end

    context 'when user is not logged in' do
      it 'does not destroy the post' do
        post = create(:post)

        expect do
          delete :destroy,
                 params: { id: post.to_param, user_id: post.user.id }
        end.not_to change(Post, :count)
      end

      it 'displays a flash alert' do
        post = create(:post)
        delete :destroy,
               params: { id: post.to_param, user_id: post.user.id }

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end
end
