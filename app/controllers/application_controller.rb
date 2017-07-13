# ApplicationController - The application main controller
class ApplicationController < ActionController::API
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
