require 'rails_helper'

describe Post, type: :model do
  subject { create(:post) }

  describe 'validations' do
    describe 'presence validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:description) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
