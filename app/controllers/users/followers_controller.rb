# frozen_string_literal: true

module Users
  class FollowersController < ApplicationController
    before_action :set_user

    # GET /users/1/followers
    def index
      @users = @user.followers.page(params[:page])
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
