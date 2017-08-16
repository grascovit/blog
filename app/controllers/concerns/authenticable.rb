# frozen_string_literal: true

module Authenticable
  def authenticate_user
    current_user || unauthorized
  end

  def unauthorized
    flash[:alert] = t('controllers.session.unauthorized')
    redirect_to new_session_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
