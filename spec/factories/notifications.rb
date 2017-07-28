# frozen_string_literal: true

FactoryGirl.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    action { Notification.actions.keys.sample }
    user
  end
end
