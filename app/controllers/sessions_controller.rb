# SessionsController - Manages the client sessions
class SessionsController < ApplicationController
  include Swagger::Blocks
  include Docs::SessionsController

  def new
    render json: { message: 'You are not authenticated' }
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { data: { user: UserSerializer.serialize(user) } }, status: :ok
    else
      render json: {
        errors: { authentication: ['You have entered incorrect email and/or password'] }
      }, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    head :ok
  end
end
