# WelcomeController - Just to serve as welcoming endpoint
class WelcomeController < ActionController::API
  def index
    render json: { message: 'Yaaay! The Microblog API is running ! Check the /docs for more information' }
  end
end
