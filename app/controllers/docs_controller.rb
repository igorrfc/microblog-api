# DocsController - holds the api documentation logic.
class DocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, Rails.application.config.version
      key :title, 'Microblog API'
      key :description, 'The Microblog API'
      contact do
        key :name, 'Igor Fernandes'
        key :email, 'igorrfc10@gmail.com'
      end
    end
    tag do
      key :name, 'api'
      key :description, 'API Info Relative operations'
    end
    tag do
      key :name, 'user'
      key :description, 'Users operations'
    end
    tag do
      key :name, 'post'
      key :description, 'Posts operations'
    end
    tag do
      key :name, 'notification'
      key :description, 'Notification operations'
    end
    tag do
      key :name, 'session'
      key :description, 'Session management'
    end
    key :schemes, %w[http]
    key :consumes, ['application/json']
    key :produces, ['application/json']
    key :basePath, '/'
  end

  SWAGGERED_CLASSES = [
    Api::V1::UsersController,
    Api::V1::PostsController,
    Api::V1::NotificationsController,
    SessionsController,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
