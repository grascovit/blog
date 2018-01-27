# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authenticable

  before_action :authenticate_user
  before_action :set_notifications, if: :user_signed_in?

  protect_from_forgery with: :exception

  def set_notifications
    @notifications = current_user.notifications.by_created_date
  end
end
