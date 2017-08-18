# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FollowersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'users/1/followers').to route_to('users/followers#index', user_id: '1')
    end
  end
end
