# User - represents an user
class User < ApplicationRecord
  has_secure_password

  has_many :posts

  has_many :followers, through: :follower_follows, source: :follower
  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow'

  has_many :followees, through: :followee_follows, source: :followee
  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow'

  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
