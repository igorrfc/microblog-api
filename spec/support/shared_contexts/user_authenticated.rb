RSpec.shared_context 'user authenticated', shared_context: :metadata do
  let(:token) { double acceptable?: true }
  let(:current_user) { create(:user) }

  before do
    session[:user_id] = current_user.id
    allow(controller).to receive(:doorkeeper_token) { token }
  end
end
