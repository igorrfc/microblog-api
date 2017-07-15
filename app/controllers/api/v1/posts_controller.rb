module Api
  module V1
    # PostsController - holds the posts endpoints.
    class PostsController < ApplicationController
      include Swagger::Blocks
      include Docs::PostsController
      before_action :doorkeeper_authorize!

      def index
        render json: { data: Post.where(user_id: params[:user_id]) }, status: :ok
      end

      def create
        post = Post.new(post_params)
        post.user = User.find(params[:user_id])

        if post.save
          render json: { data: post }, status: :created
        else
          render json: { errors: post.errors }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :description)
      end
    end
  end
end
