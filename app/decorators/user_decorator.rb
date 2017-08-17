class UserDecorator < Draper::Decorator
  delegate_all

  delegate :nil?

  def home_link
    if present?
      h.user_path(object)
    else
      h.root_path
    end
  end
end
