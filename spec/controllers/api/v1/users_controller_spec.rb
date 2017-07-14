require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    context 'when there is an user with the received id param' do
      let!(:user) { create(:user, name: 'Scott') }
      let(:user_found) { hash_format_response[:data] }

      before { get :show, params: { id: user.id } }

      it 'returns the user' do
        expect(user_found[:name]).to eq 'Scott'
      end

      it 'returns an user json without the "passowrd_digest information"' do
        expect(user_found).to_not have_key :password_digest
      end
    end

    context 'when the user does not exist' do
      it 'returns a not found http status' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'when all the user parameters are valid' do
      let(:user_params) { attributes_for(:user) }

      before { post :create, params: { user: user_params } }

      it 'returns a "created" http status' do
        expect(response).to have_http_status(:created)
      end

      it 'creates an user' do
        created_user = hash_format_response[:data]
        expect(created_user[:id]).to_not be_nil
      end
    end

    context 'when an invalid parameter was sent' do
      let(:user_params) { attributes_for(:user, email: 'invalidmail@') }

      before { post :create, params: { user: user_params } }

      it 'returns a "unprocessable_entity" http status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a json response with an "errors" key' do
        expect(hash_format_response[:errors]).to include(email: ['is invalid'])
      end
    end
  end
end
