# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'users/1/posts/1').to route_to('users/posts#show', id: '1', user_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'users/1/posts/1/edit').to route_to('users/posts#edit', id: '1', user_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'users/1/posts').to route_to('users/posts#create', user_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'users/1/posts/1').to route_to('users/posts#update', id: '1', user_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'users/1/posts/1').to route_to('users/posts#update', id: '1', user_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'users/1/posts/1').to route_to('users/posts#destroy', id: '1', user_id: '1')
    end
  end
end
