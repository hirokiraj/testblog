Rails.application.routes.draw do
  devise_for :users
  root 'home#welcome'
  # get '/authors', to: 'authors#index', as: :authors
  # get '/authors/:id', to: 'authors#show', as: :author
  # get '/author/new', to: 'authors#new', as: :new_author
  resources :authors

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
