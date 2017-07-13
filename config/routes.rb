Rails.application.routes.draw do
  resources :docs, only: [:index]

  namespace :api do
    scope module: :v1 do
      resources :users, only: [:create]
    end
  end
end
