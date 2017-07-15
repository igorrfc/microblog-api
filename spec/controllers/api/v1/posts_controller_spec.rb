require 'rails_helper'

describe Api::V1::PostsController, type: :controller do
  describe 'GET #index' do
    context 'when there is a logged user' do
      include_context 'user authenticated'
      let(:user) { create(:user) }
      let!(:user_posts) { JSON.parse(create_list(:post, 2, user: user).to_json) }

      before { create_list(:post, 2) }

      it 'returns all the user posts' do
        get :index, params: { user_id: user.id }
        expect(hash_format_response[:data]).to eq user_posts
      end

      it 'returns a "success" http status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        get :index, params: { user_id: 1, id: 1 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'when there is a logged user' do
      include_context 'user authenticated'

      context 'and all parameters are valid' do
        let(:post_params) { { title: 'Foo title', description: 'Foo description', user_id: user.id } }
        let(:created_post) { hash_format_response[:data] }

        before { post :create, params: { user_id: user.id, post: post_params } }

        it 'returns a "created" http status' do
          expect(response).to have_http_status(:created)
        end

        it 'creates a new post' do
          expect(created_post[:id]).to_not be_nil
        end

        it 'associates the created post to the user' do
          expect(created_post[:user_id]).to eq user.id
        end
      end

      context 'and there is an invalid parameter' do
        it 'returns an error' do
          post :create, params: { user_id: user.id, post: { title: 'Foo', description: '' } }
          expect(hash_format_response[:errors]).to include(description: ["can't be blank"])
        end
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        post :create, params: { user_id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
