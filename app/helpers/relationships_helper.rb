# frozen_string_literal: true

module RelationshipsHelper
  def follow_user_button
    return if @current_user.nil? || @user.nil?

    if @current_user.follows?(@user)
      link_to t('views.relationship.destroy'),
              user_relationship_path(@user, @relationship),
              method: :delete,
              class: 'ui submit tiny red inverted button'
    elsif @user != @current_user
      link_to t('views.relationship.create'),
              user_relationships_path(@user),
              method: :post,
              class: 'ui submit tiny green inverted button'
    else
      ''
    end
  end
end
