# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FollowingController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'users/1/following').to route_to('users/following#index', user_id: '1')
    end
  end
end
