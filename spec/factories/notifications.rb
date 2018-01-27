# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    action { Notification.actions.keys.sample }
    user
  end
end
