# FollowUser - associates a follower to the received user and sends a notification.
class FollowUser
  attr_reader :user, :follower

  def initialize(user, follower)
    @user = user
    @follower = follower
  end

  def self.process(user, follower:)
    new(user, follower).process
  end

  def process
    User.transaction do
      user.followers << follower
      Notification.create(message: new_follower_message, user: user)
    end
  end

  private

  def new_follower_message
    "#{follower.nickname} is following you."
  end
end
