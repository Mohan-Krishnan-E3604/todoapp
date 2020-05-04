Rails.application.routes.draw do

  resources :boards
  resources :lists do
    collection do
      get 'search'
    end
  end
  resources :items
  post 'auth/login', to: 'authentication#authenticate'
  post 'users', to: 'users#create'
  get 'users/auto_complete', to: 'users#auto_complete'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
