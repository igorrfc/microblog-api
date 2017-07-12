# Follow - represents the join table between user and followers and followees
class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :followee, foreign_key: 'followee_id', class_name: 'User'
end
