# frozen_string_literal: true

module Users
  class FollowingController < ApplicationController
    before_action :set_user

    # GET /users/1/following
    def index
      @users = @user.following.page(params[:page])
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
