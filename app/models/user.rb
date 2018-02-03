# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch

  has_secure_password

  has_many :followers_relationships, class_name: 'Relationship', foreign_key: 'following_id',
                                     inverse_of: :following, dependent: :destroy
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id',
                                     inverse_of: :follower, dependent: :destroy
  has_many :followers, through: :followers_relationships, source: :follower
  has_many :following, through: :following_relationships, source: :following
  has_many :notifications, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: ':style/missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}

  paginates_per 8

  pg_search_scope :search_by_name,
                  against: %i[first_name last_name],
                  using: {
                    tsearch: { prefix: true },
                    trigram: {},
                    dmetaphone: {}
                  }

  def self.search(query)
    if query.present?
      search_by_name(query)
    else
      all
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def follows?(user)
    Relationship.exists?(follower: self, following: user)
  end

  def posts_by_user(current_user)
    posts = current_user == self ? Post.following_and_mine(self) : self.posts

    posts.includes(:user).by_created_date
  end
end
