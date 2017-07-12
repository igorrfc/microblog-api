# User - represents an user
class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
