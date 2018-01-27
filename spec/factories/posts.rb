# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    message { Faker::Lorem.paragraph }
    user
  end

  factory :invalid_post, parent: :post do
    message nil
    user nil
  end
end
