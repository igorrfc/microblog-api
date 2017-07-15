Rails.application.routes.draw do
  use_doorkeeper
  root 'welcome#index'
  resources :docs, only: [:index]

  resources :sessions, only: %i[new create]
  delete '/logout', to: 'sessions#destroy'

  namespace :api do
    scope module: :v1 do
      resources :users, only: %i[create show index] do
        resources :notifications, only: %i[update index]
        resources :posts, only: %i[index create]
        collection do
          get :search
          post :follow
        end
      end
    end
  end
end
