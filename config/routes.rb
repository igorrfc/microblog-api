Rails.application.routes.draw do
  namespace :api do
    scope module: :v1 do
      resources :users, only: [:create]
    end
  end
end
