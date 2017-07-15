module Docs
  module PostsController
    extend ActiveSupport::Concern

    included do
      swagger_schema :PostInput do
        allOf do
          schema do
            key :'$ref', :PostFields
          end

          schema do
            key :required, [:title, :description]
            property :title do
              key :type, :string
            end
            property :description do
              key :type, :string
            end
          end
        end
      end

      swagger_path '/api/users/{:user_id}/posts' do
        operation :get do
          key :description, "Fetches for all user's posts"
          key :operation_id, 'fetchPosts'
          key :tags, [
            'post'
          ]

          parameter do
            key :name, :user_id
            key :in, :path
            key :description, "The id of posts creator"
            key :required, true
          end

          security do
            key :api_auth, ['api']
          end

          response 200 do
            key :description, 'success on fetch user posts'
          end
        end
      end

      swagger_path '/api/users/{:user_id}/posts' do
        operation :post do
          key :description, 'Registers a new post'
          key :operation_id, 'createPost'
          key :tags, [
            'post'
          ]

          parameter do
            key :name, :user_id
            key :in, :path
            key :description, "The id of post's creator"
            key :required, true
          end

          parameter do
            key :name, :post
            key :in, :body
            key :description, 'Post to be created'
            key :required, true
            schema do
              key :required, [:post]
              property :post do
                key :'$ref', :PostInput
              end
            end
          end

          security do
            key :api_auth, ['api']
          end

          response 201 do
            key :description, 'post created response'
          end

          response 422 do
            key :description, 'invalid parameters sent'
          end
        end
      end
    end
  end
end
