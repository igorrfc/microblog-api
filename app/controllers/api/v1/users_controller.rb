module Api
  module V1
    # EstablishmentsController - holds the establishments logic.
    class UsersController < ApplicationController
      include Swagger::Blocks
      include Docs::UsersController

      before_action :doorkeeper_authorize!, only: %i[search follow index]

      def index
        users = User.followees_suggestion
        render json: { data: UserSerializer.serialize(users) }, status: :ok
      end

      def show
        user = User.find_by(id: params[:id])

        if user
          render json: {
            data: UserSerializer.serialize(user)
          }, status: :ok
        else
          head :not_found
        end
      end

      def create
        user = User.new(user_params)

        if user.save
          session[:user_id] = user.id
          render json: { data: user.as_json(except: :password_digest) }, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      def search
        users = User.search(params[:query])
        render json: { data: UserSerializer.serialize(users) }, status: :ok
      end

      def follow
        return head :not_found unless params[:follower_id]

        user = User.find(params[:id])
        follower = User.find(params[:follower_id])
        FollowUser.process(user, follower: follower)

        head :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
      end
    end
  end
end
