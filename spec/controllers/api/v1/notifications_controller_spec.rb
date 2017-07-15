require 'rails_helper'

describe Api::V1::NotificationsController, type: :controller do
  describe 'GET #index' do
    context 'when there is a logged user' do
      include_context 'user authenticated'
      let(:user) { create(:user) }
      let!(:user_notifications) { JSON.parse(create_list(:notification, 2, user: user).to_json) }

      before { create_list(:notification, 2) }

      it 'returns all the user notifications' do
        get :index, params: { user_id: user.id }
        expect(hash_format_response[:data]).to eq user_notifications
      end

      it 'returns a "success" http status' do
        get :index, params: { user_id: user.id }
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

  describe 'PUT #update' do
    context 'when there is a logged user' do
      include_context 'user authenticated'
      let(:notification) { create(:notification) }

      before do
        put :update, params: {
          id: notification.id,
          user_id: notification.user.id,
          notification: params
        }
      end

      context 'and all parameters sent are valid' do
        let(:params) { { visualized: true } }

        it 'updates the notification' do
          expect(hash_format_response[:data][:visualized]).to eq true
        end

        it 'returns a "success" http status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'and there is an invalid parameter' do
        let(:params) { { message: '' } }

        it 'updates the notification' do
          expect(hash_format_response[:errors]).to include(message: ["can't be blank"])
        end

        it 'returns a "unprocessable_entity" http status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when there is no user logged in' do
      it 'responds with the unauthorized http status' do
        put :update, params: { user_id: 1, id: 1 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
