require 'rails_helper'

describe Notification, type: :model do
  describe 'associaions' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end
end
