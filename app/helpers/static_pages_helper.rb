# frozen_string_literal: true

module StaticPagesHelper
  def home_link
    if @current_user.present?
      user_path(@current_user)
    else
      root_path
    end
  end
end
