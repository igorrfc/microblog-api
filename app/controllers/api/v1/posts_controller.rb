module Api
  module V1
    # PostsController - holds the posts endpoints.
    class PostsController < ApplicationController
      include Swagger::Blocks
      include Docs::PostsController
      before_action :doorkeeper_authorize!

      def create
        post = Post.new(post_params)
        post.user = current_user

        if post.save
          render json: { data: post }, status: :created
        else
          render json: { errors: post.errors }
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :description)
      end
    end
  end
end
