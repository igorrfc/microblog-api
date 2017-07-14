require 'rails_helper'

describe FollowUser do
  describe 'process' do
    let(:user) { create(:user) }
    let(:follower) { create(:user, nickname: 'follower') }

    before { described_class.process(user, follower: follower) }

    it 'associates a new follower to the user received' do
      expect(user.followers).to contain_exactly follower
    end

    it 'notificates the user about the new follower' do
      notifications = user.notifications

      expect(notifications.count).to eq 1
      expect(notifications.first.message).to eq 'follower is following you.'
    end
  end
end
