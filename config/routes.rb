Rails.application.routes.draw do
  resources :lists do
    collection do
      get 'search'
    end
  end
  resources :items
  post 'auth/login', to: 'authentication#authenticate'
  post 'users', to: 'users#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
