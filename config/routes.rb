Rails.application.routes.draw do
  use_doorkeeper
  resources :docs, only: [:index]

  resources :sessions, only: %i[new create]
  delete '/logout', to: 'sessions#destroy'

  namespace :api do
    scope module: :v1 do
      resources :users, only: %i[create show] do
        resources :notifications, only: %i[update index]
        collection do
          get :search
          post :follow
        end
      end
      resources :posts, only: %i[index create]
    end
  end
end
