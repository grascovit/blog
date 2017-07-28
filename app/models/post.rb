# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  scope :by_created_date, -> { order(created_at: :desc) }
  scope :following_and_mine, ->(user) {
    where(user_id: [user.id, user.following.pluck(:id)].flatten)
  }
end
