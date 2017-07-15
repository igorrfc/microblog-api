module Api
  module V1
    # NotificationsController - holds the notification logic.
    class NotificationsController < ApplicationController
      include Swagger::Blocks
      include Docs::NotificationsController

      before_action :doorkeeper_authorize!

      def index
        render json: { data: Notification.where(user_id: params[:user_id]) }, status: :ok
      end

      def update
        notification = Notification.find(params[:id])

        if notification.update(notifcation_params)
          render json: { data: notification }, status: :ok
        else
          render json: { errors: notification.errors }, status: :unprocessable_entity
        end
      end

      private

      def notifcation_params
        params.require(:notification).permit(:message, :visualized)
      end
    end
  end
end
