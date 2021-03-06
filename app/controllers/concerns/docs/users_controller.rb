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
        operation :get do
          key :description, 'Returns at least 10 users randomly'
          key :operation_id, 'listUsers'
          key :tags, [
            'user'
          ]

          response 200 do
            key :description, 'success on fetch users'
          end
        end

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

          response 422 do
            key :description, 'invalid parameters sent'
          end
        end
      end

      swagger_path '/api/users/{:id}' do
        operation :get do
          key :description, 'Looks for an user'
          key :operation_id, 'getUser'
          key :tags, [
            'user'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :description, 'User id'
            key :type, :integer
            key :required, true
          end

          response 200 do
            key :description, 'user found'
          end

          response 404 do
            key :description, 'user not found'
          end
        end
      end

      swagger_path 'api/users/search' do
        operation :get do
          key :description, 'Search users by name, nickname or email'
          key :operation_id, 'searchUser'
          key :tags, [
            'user'
          ]

          parameter do
            key :name, :query
            key :in, :query
            key :description, 'It can be a name, username or email'
            key :type, :string
            key :required, true
          end

          security do
            key :api_auth, ['api']
          end

          response 200 do
            key :description, 'search finishes'
          end
        end
      end

      swagger_path 'api/users/{:id}/follow' do
        operation :post do
          key :description, 'Follows an user'
          key :operation_id, 'followUser'
          key :tags, [
            'user'
          ]

          parameter do
            key :name, :id
            key :in, :body
            key :description, 'the id of the user that will be followed'
            key :type, :integer
            key :required, true
          end

          parameter do
            key :name, :follower_id
            key :in, :query
            key :description, 'the follower id'
            key :type, :integer
            key :required, true
          end

          security do
            key :api_auth, ['api']
          end

          response 200 do
            key :description, 'user successfully followed response'
          end

          response 404 do
            key :description, 'user not found'
          end
        end
      end
    end
  end
end
