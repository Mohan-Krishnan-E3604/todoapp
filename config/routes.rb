Rails.application.routes.draw do
  resources :lists do
    collection do
      get 'search'
    end
    resources :items
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
