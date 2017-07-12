require 'rails_helper'

describe Follow, type: :model do
  describe 'associaions' do
    it { is_expected.to belong_to(:followee) }
    it { is_expected.to belong_to(:follower) }
  end
end
