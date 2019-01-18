# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :invalid_user, parent: :user do
    first_name { nil }
    last_name { nil }
    username { nil }
    email { nil }
    password { nil }
  end
end
