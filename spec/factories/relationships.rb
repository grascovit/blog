# frozen_string_literal: true

FactoryGirl.define do
  factory :relationship do
    follower
    followed
  end
end
