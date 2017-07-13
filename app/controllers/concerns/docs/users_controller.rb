module Docs
  module UsersController
    extend ActiveSupport::Concern

    included do
      swagger_schema :UserInput do
        allOf do
          schema do
            key :'$ref', :UserFields
          end

          schema do
            key :required, [:name, :nickname, :email, :password]
            property :name do
              key :type, :string
            end
            property :nickname do
              key :type, :string
            end
            property :email do
              key :type, :string
            end
            property :password do
              key :type, :string
            end
          end
        end
      end
      swagger_path '/api/users' do
        operation :post do
          key :description, 'Registers a new user'
          key :operation_id, 'createUser'
          key :tags, [
            'user'
          ]
          parameter do
            key :name, :user
            key :in, :body
            key :description, 'User to be created'
            key :required, true
            schema do
              key :required, [:user]
              property :user do
                key :'$ref', :UserInput
              end
            end
          end

          response 201 do
            key :description, 'user created response'
          end
        end
      end
    end
  end
end
