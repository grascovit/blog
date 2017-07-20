# frozen_string_literal: true

module ApplicationHelper
  def flash_message_class(type)
    if type == 'notice'
      'positive'
    elsif type == 'alert'
      'negative'
    end
  end
end
