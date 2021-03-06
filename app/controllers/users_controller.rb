# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create show]
  before_action :set_user, only: %i[show]
  before_action :set_posts, only: %i[show]
  before_action :set_relationship, only: %i[show]

  # GET /users
  def index
    @users = User.search(params[:query]).page(params[:page])
  end

  # GET /users/1
  def show
    @post = current_user.posts.build if user_signed_in?
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: t('controllers.user.created')
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: t('controllers.user.updated')
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy

    redirect_to users_url, notice: t('controllers.user.destroyed')
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :avatar
    )
  end

  def set_user
    @user = User.find(params[:id]).decorate
  end

  def set_posts
    @posts = @user.posts_by_user(current_user).page(params[:page])
  end

  def set_relationship
    @relationship = Relationship.find_by(follower: current_user, following: @user)
  end
end
