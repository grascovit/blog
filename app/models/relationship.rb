# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :following_relationships
  belongs_to :following, class_name: 'User', inverse_of: :followers_relationships

  validates :follower_id, presence: true
  validates :following_id, presence: true

  after_create :create_notification

  private

  def create_notification
    Notification.create(
      message: I18n.t('views.notification.user_started_following', username: follower.username),
      action: :user_started_following,
      user: following
    )
  end
end
