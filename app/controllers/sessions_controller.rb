# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user, except: [:destroy]

  def new; end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:alert] = t('controllers.session.bad_credentials')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
