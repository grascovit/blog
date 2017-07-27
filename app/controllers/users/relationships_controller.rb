# frozen_string_literal: true

module Users
  class RelationshipsController < ApplicationController
    before_action :set_follower
    before_action :set_following
    before_action :set_relationship, only: [:destroy]

    # POST /users/1/relationships
    def create
      @relationship = Relationship.new(follower: @follower, following: @following)

      if (@follower != @following) && @relationship.save
        redirect_to @following, notice: t('controllers.relationship.created', username: @following.username)
      else
        redirect_to @following
      end
    end

    # DELETE /users/1/relationships/1
    def destroy
      @relationship.destroy
      redirect_to @following, notice: t('controllers.relationship.destroyed', username: @following.username)
    end

    private

    def set_follower
      @follower = current_user
    end

    def set_following
      @following = User.find(params[:user_id])
    end

    def set_relationship
      @relationship = Relationship.find_by(follower: @follower, following: @following)
    end
  end
end
