# frozen_string_literal: true

module Users
  class PostsController < ApplicationController
    before_action :set_user
    before_action :set_post, only: %i[edit update show destroy]

    # GET /users/1/posts/1
    def show; end

    # GET /users/1/posts/1/edit
    def edit; end

    # POST /users/1/posts
    def create
      @post = @user.posts.build(post_params)

      if @post.save
        redirect_to @user, notice: t('controllers.post.created')
      else
        redirect_to @user
      end
    end

    # PATCH/PUT /users/1/posts/1
    def update
      if @post.update(post_params)
        redirect_to current_user, notice: t('controllers.post.updated')
      else
        redirect_to current_user
      end
    end

    # DELETE /users/1/posts/1
    def destroy
      @post.destroy
      redirect_to current_user, notice: t('controllers.post.destroyed')
    end

    private

    def set_user
      @user = current_user
    end

    def set_post
      @post = current_user.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:message)
    end
  end
end
