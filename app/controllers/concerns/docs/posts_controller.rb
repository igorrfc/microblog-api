module Docs
  module PostsController
    extend ActiveSupport::Concern

    included do
      swagger_schema :PostInput do
        allOf do
          schema do
            key :'$ref', :UserFields
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
      swagger_path '/api/posts' do
        operation :post do
          key :description, 'Registers a new post'
          key :operation_id, 'createPost'
          key :tags, [
            'post'
          ]

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
        end
      end
    end
  end
end
