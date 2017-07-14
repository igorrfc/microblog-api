require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns a user not authenticated message' do
      get :new
      expect(hash_format_response[:message]).to eq 'You are not authenticated'
    end
  end

  describe 'POST #create' do
    let(:email) { 'foo@bar.com' }

    context 'when there is an user matching the email received and with the correct password' do
      let(:password) { 'foopassword' }
      let!(:user) { create(:user, email: email, password: password, password_confirmation: password) }

      before { post :create, params: { email: email, password: password } }

      it 'returns a "success" http response' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the session[:user_id] with the received user' do
        expect(session[:user_id]).to eq user.id
      end
    end

    context 'when there is no user with the email received as parameter' do
      before { post :create, params: { email: email } }

      it 'returns a "unprocessable_entity" http response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an invalid email/password error' do
        expect(hash_format_response[:errors])
          .to include(authentication: ['You have entered incorrect email and/or password'])
      end
    end
  end

  describe 'POST #destroy' do
    before { delete :destroy }

    it 'returns a "success" http response' do
      expect(response).to have_http_status(:ok)
    end

    it 'removes the session[:user_id]' do
      expect(session[:user_id]).to be_nil
    end
  end
end
