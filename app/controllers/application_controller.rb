# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authenticable

  before_action :authenticate_user

  protect_from_forgery with: :exception
end
