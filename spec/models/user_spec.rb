require 'rails_helper'

describe User, type: :model do
  subject { create(:user) }

  describe 'associaions' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:notifications) }
    it { is_expected.to have_many(:followers).through(:follower_follows) }
    it { is_expected.to have_many(:followees).through(:followee_follows) }
  end

  describe 'validations' do
    describe 'presence validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:nickname) }
      it { is_expected.to validate_presence_of(:email) }
    end

    describe 'format validations' do
      describe 'email' do
        context 'when it has a valid domain and a ".com"' do
          it 'returns a valid user' do
            user = build(:user, email: 'valid@mail.com')
            expect(user).to be_valid
          end
        end

        context 'when it does not have a domain' do
          it 'returns a invalid user' do
            user = build(:user, email: 'invalid.mail')
            expect(user).to be_invalid
          end
        end

        context 'when it does not have a ".com"' do
          it 'returns a invalid user' do
            user = build(:user, email: 'invalid@mail')
            expect(user).to be_invalid
          end
        end
      end
    end
  end

  describe '.new' do
    context 'when a password value is received as param' do
      it 'returns a user with a digested password' do
        user = build(:user)
        expect(user.password_digest).to_not be_nil
      end
    end
  end
end
