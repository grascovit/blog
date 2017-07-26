# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :followers_relationships, class_name: 'Relationship',
                                     foreign_key: 'following_id', dependent: :destroy
  has_many :following_relationships, class_name: 'Relationship',
                                     foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :followers_relationships, source: :follower
  has_many :following, through: :following_relationships, source: :following
  has_many :posts, dependent: :destroy

  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: ':style/missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}

  def full_name
    "#{first_name} #{last_name}"
  end

  def follows?(user)
    Relationship.exists?(follower: self, following: user)
  end
end
