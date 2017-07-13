require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
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
