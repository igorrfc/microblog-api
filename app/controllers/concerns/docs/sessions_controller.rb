module Docs
  module SessionsController
    extend ActiveSupport::Concern

    included do
      swagger_path '/sessions' do
        operation :post do
          key :description, 'Creates a login session'
          key :operation_id, 'createSession'
          key :tags, [
            'session'
          ]

          parameter do
            key :name, :email
            key :in, :query
            key :description, 'User email'
            key :type, :string
            key :required, true
          end

          parameter do
            key :name, :password
            key :in, :query
            key :description, 'User password'
            key :type, :string
            key :required, true
          end

          response 200 do
            key :description, 'session successfully created'
          end
        end
      end
    end
  end
end
