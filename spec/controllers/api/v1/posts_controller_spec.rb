require 'rails_helper'

describe Api::V1::PostsController, type: :controller do
  describe 'POST #create' do
    context 'when there is a logged user' do
      include_context 'user authenticated'

      context 'and all parameters are valid' do
        let(:post_params) { { title: 'Foo title', description: 'Foo description' } }
        let(:created_post) { hash_format_response[:data] }

        before { post :create, params: { post: post_params } }

        it 'returns a "created" http status' do
          expect(response).to have_http_status(:created)
        end

        it 'creates a new post' do
          expect(created_post[:id]).to_not be_nil
        end

        it 'associates the created post to the logged user' do
          expect(created_post[:user_id]).to eq current_user.id
        end
      end

      context 'and there is an invalid parameter' do
        it 'returns an error' do
          post :create, params: { post: { title: 'Foo', description: '' } }
          expect(hash_format_response[:errors]).to include(description: ["can't be blank"])
        end
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
