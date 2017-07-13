module Api
  module V1
    # EstablishmentsController - holds the establishments logic.
    class UsersController < ApplicationController
      include Swagger::Blocks
      include Docs::UsersController

      def create
        user = User.new(user_params)

        if user.save
          session[:user_id] = user.id
          render json: { data: user }, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
      end
    end
  end
end
