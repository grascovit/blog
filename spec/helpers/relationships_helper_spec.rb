# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelationshipsHelper, type: :helper do
  describe '#follow_user_button' do
    context 'when user is logged in' do
      context 'when user already follows the visited user' do
        it 'returns a link to destroy the relationship' do
          @current_user = create(:user)
          @user = create(:user)
          @relationship = create(:relationship, follower: @current_user, following: @user)
          session[:user_id] = @current_user.id

          expect(helper.follow_user_button).to include user_relationship_path(@user, @relationship)
        end
      end

      context 'when user visits an user that he/she does not follows yet' do
        it 'returns a link to create a relationship' do
          @current_user = create(:user)
          @user = create(:user)
          session[:user_id] = @current_user.id

          expect(helper.follow_user_button).to include user_relationships_path(@user)
        end
      end

      context 'when user visits his own page' do
        it 'returns empty string' do
          @current_user = create(:user)
          @user = @current_user
          session[:user_id] = @current_user.id

          expect(helper.follow_user_button).to eq ''
        end
      end
    end

    context 'when user is not logged in' do
      it 'returns nil' do
        @user = create(:user)

        expect(helper.follow_user_button).to eq nil
      end
    end
  end
end
