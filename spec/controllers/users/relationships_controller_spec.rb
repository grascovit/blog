# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RelationshipsController, type: :controller do
  let(:follower) { create(:user) }
  let(:following) { create(:user) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new relationship' do
        expect do
          post :create,
               params: { user_id: following.id },
               session: { user_id: follower.id }
        end.to change(Relationship, :count).by(1)
      end

      it 'redirects to the following user' do
        post :create,
             params: { user_id: following.id },
             session: { user_id: follower.id }

        expect(response).to redirect_to(following)
      end
    end

    context 'when follower and following are the same' do
      it 'does not create a new relationship' do
        expect do
          post :create,
               params: { user_id: follower.id },
               session: { user_id: follower.id }
        end.not_to change(Relationship, :count)
      end

      it 'redirects to the following user' do
        post :create,
             params: { user_id: follower.id },
             session: { user_id: follower.id }

        expect(response).to redirect_to(follower)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'destroys the requested relationship' do
        relationship = create(:relationship, follower: follower, following: following)

        expect do
          delete :destroy,
                 params: { id: relationship.to_param, user_id: following.id },
                 session: { user_id: follower.id }
        end.to change(Relationship, :count).by(-1)
      end

      it 'redirects to the following user' do
        relationship = create(:relationship, follower: follower, following: following)

        delete :destroy,
               params: { id: relationship.to_param, user_id: following.id },
               session: { user_id: follower.id }

        expect(response).to redirect_to(following)
      end
    end

    context 'when user is not logged in' do
      it 'does not destroy the relationship' do
        relationship = create(:relationship, follower: follower, following: following)

        expect do
          delete :destroy,
                 params: { id: relationship.to_param, user_id: following.id }
        end.not_to change(Relationship, :count)
      end

      it 'displays a flash alert' do
        relationship = create(:relationship, follower: follower, following: following)

        delete :destroy,
               params: { id: relationship.to_param, user_id: following.id }

        expect(flash[:alert]).to eq I18n.t('controllers.session.unauthorized')
      end
    end
  end
end
