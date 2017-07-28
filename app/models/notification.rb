# frozen_string_literal: true

class Notification < ApplicationRecord
  enum action: [:user_started_following]

  belongs_to :user

  validates :message, presence: true
  validates :action, presence: true

  scope :by_created_date, -> { order(created_at: :desc) }

  def read?
    read_at.present?
  end
end
