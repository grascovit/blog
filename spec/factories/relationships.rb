# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    follower { create(:user) }
    following { create(:user) }
  end

  factory :invalid_relationship do
    follower { nil }
    following { nil }
  end
end
