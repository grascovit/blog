# frozen_string_literal: true

module ApplicationHelper
  include Authenticable

  def flash_message_class(type)
    if type == 'notice'
      'positive'
    elsif type == 'alert'
      'negative'
    end
  end

  def home_link
    if current_user.present?
      user_path(current_user)
    else
      root_path
    end
  end
end
