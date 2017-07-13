Rails.application.routes.draw do
  resources :docs, only: [:index]

  resources :sessions, only: [:create]
  delete '/logout', to: 'sessions#destroy'

  namespace :api do
    scope module: :v1 do
      resources :users, only: [:create]
    end
  end
end
