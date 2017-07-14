Rails.application.routes.draw do
  use_doorkeeper
  resources :docs, only: [:index]

  resource :sessions, only: %i[new create]
  delete '/logout', to: 'sessions#destroy'

  namespace :api do
    scope module: :v1 do
      resource :users, only: %i[create show] do
        member do
          get :search
          post :follow
        end
      end
      resource :posts, only: %i[index create]
    end
  end
end
