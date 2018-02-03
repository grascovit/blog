# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#follow_user_button' do
    context 'when user is logged in' do
      context 'when user already follows the visited user' do
        it 'returns a link to destroy the relationship' do
          current_user = create(:user)
          user = create(:user).decorate
          relationship = create(:relationship, follower: current_user, following: user)
          h.session[:user_id] = current_user.id

          expect(user.follow_button(current_user, relationship)).to include h.user_relationship_path(user, relationship)
        end
      end

      context 'when user visits an user that he/she does not follows yet' do
        it 'returns a link to create a relationship' do
          current_user = create(:user)
          user = create(:user).decorate
          h.session[:user_id] = current_user.id

          expect(user.follow_button(current_user, nil)).to include h.user_relationships_path(user)
        end
      end

      context 'when user visits his own page' do
        it 'returns empty string' do
          current_user = create(:user)
          user = current_user.decorate
          h.session[:user_id] = current_user.id

          expect(user.follow_button(current_user, nil)).to eq ''
        end
      end
    end

    context 'when user is not logged in' do
      it 'returns empty string' do
        user = create(:user).decorate

        expect(user.follow_button(nil, nil)).to eq ''
      end
    end
  end
end
