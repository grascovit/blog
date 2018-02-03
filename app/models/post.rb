# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  paginates_per 10

  scope :by_created_date, -> { order(created_at: :desc) }
  scope :following_and_mine, lambda { |user|
    where(user_id: [user.id, user.following.pluck(:id)].flatten)
  }
end
