# frozen_string_literal: true

module Authenticable
  def authenticate_user
    current_user || unauthorized
  end

  def unauthorized
    flash[:alert] = 'Você precisa fazer login ou se cadastrar antes de continuar'
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
