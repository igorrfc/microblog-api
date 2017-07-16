require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    context 'when there is a logged user' do
      include_context 'user authenticated'
      let!(:users_list) { create_list(:user, 2) }

      it 'returns at least 10 followees suggestions' do
        get :index

        response_users = hash_format_response[:data].delete_if do |user|
          user[:id] == current_user.id
        end

        user_names = users_list.map(&:name).sort
        response_user_names = response_users.map { |user| user[:name] }.sort

        expect(response_user_names).to eq user_names
      end

      it 'returns a "success" http status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    context 'when there is an user with the received id param' do
      let!(:user) { create(:user, name: 'Scott') }
      let(:user_found) { hash_format_response[:data] }

      before { get :show, params: { id: user.id } }

      it 'returns the user' do
        expect(user_found[:name]).to eq 'Scott'
      end

      it 'returns an user json without the "password_digest information"' do
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

  describe 'GET #search' do
    context 'when there is a logged user' do
      include_context 'user authenticated'

      before { create_list(:user, 2, name: 'Not matched', nickname: 'notmatched') }

      it 'returns a "success" http status' do
        get :search
        expect(response).to have_http_status(:ok)
      end

      context 'when there is some user matching the query param' do
        let!(:matched_user) { create(:user, name: 'Bruce Wayne') }

        before { get :search, params: { query: 'bruce' } }

        it 'returns the matched user' do
          expect(hash_format_response[:data].size).to eq 1
          expect(hash_format_response[:data].first[:name]).to eq 'Bruce Wayne'
        end

        it 'returns the users without the "password_digest" attribute' do
          expect(hash_format_response[:data].map { |user| user[:password_digest] }.compact)
            .to be_empty
        end
      end

      context 'when there is no users matching the query param' do
        it 'returns an empty list' do
          get :search, params: { query: 'bruce' }
          expect(hash_format_response[:data]).to be_empty
        end
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        get :search
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #follow' do
    let(:user) { create(:user) }

    context 'when there is a logged user' do
      include_context 'user authenticated'

      context 'when an user id is received on params' do
        it 'returns a "success" http status' do
          allow(FollowUser).to receive(:process)
          post :follow, params: { id: user.id, follower_id: create(:user).id }

          expect(response).to have_http_status(:ok)
        end
      end

      context 'when no user id is received on params' do
        it 'returns a "not_found" http status' do
          post :follow, params: { id: user.id }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        post :follow, params: { id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
