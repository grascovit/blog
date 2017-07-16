# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  scope :by_created_date, -> { order(created_at: :desc) }
end
