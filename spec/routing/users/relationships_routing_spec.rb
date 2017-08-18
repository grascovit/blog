# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RelationshipsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'users/1/relationships').to route_to('users/relationships#create', user_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'users/1/relationships/1').to route_to('users/relationships#destroy', id: '1', user_id: '1')
    end
  end
end
