module Docs
  module NotificationsController
    extend ActiveSupport::Concern

    included do
      swagger_schema :NotificationInput do
        allOf do
          schema do
            key :'$ref', :NotificationFields
          end

          schema do
            key :required, [:message, :user_id]
            property :message do
              key :type, :string
            end
            property :user_id do
              key :type, :integer
            end
          end
        end
      end

      swagger_path '/api/users/{:user_id}/notifications' do
        operation :get do
          key :description, "Fetches for all user's notifications"
          key :operation_id, 'fetchNotifications'
          key :tags, [
            'notification'
          ]

          parameter do
            key :name, :user_id
            key :in, :path
            key :description, "The id of notification's receiver"
            key :required, true
          end

          security do
            key :api_auth, ['api']
          end

          response 200 do
            key :description, 'success on fetch user notifications'
          end
        end
      end

      swagger_path '/api/users/{:user_id}/notifications/{:id}' do
        operation :put do
          key :description, 'Updates an user notification'
          key :operation_id, 'updateNotification'
          key :tags, [
            'notification'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :description, "The notification's id"
            key :required, true
          end

          parameter do
            key :name, :user_id
            key :in, :path
            key :description, "The id of notification's receiver"
            key :required, true
          end

          parameter do
            key :name, :notification
            key :in, :body
            key :description, "The notification's updated attributes"
            key :required, true
            schema do
              key :required, [:notification]
              property :notification do
                key :'$ref', :NotificationInput
              end
            end
          end

          security do
            key :api_auth, ['api']
          end

          response 200 do
            key :description, 'notification successfully updated'
          end

          response 422 do
            key :description, 'some invalid param was sent'
          end
        end
      end
    end
  end
end
