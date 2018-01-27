# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def follow_button(current_user, relationship)
    if current_user.nil? || current_user == object
      ''
    elsif current_user.follows?(object)
      h.link_to h.t('views.relationship.destroy'),
                h.user_relationship_path(object, relationship),
                method: :delete,
                class: 'ui submit tiny red inverted button'
    elsif object != current_user
      h.link_to h.t('views.relationship.create'),
                h.user_relationships_path(object),
                method: :post,
                class: 'ui submit tiny green inverted button'
    end
  end
end
