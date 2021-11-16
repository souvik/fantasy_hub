require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq-jobs'

  get '/sessions/new', to: 'sessions#new'
  get '/sessions', to: redirect('/')
  post '/sessions', to: 'sessions#create'

  resources :users, only: [ :new, :create ] do
    resources :teams
  end

  root 'sessions#new'
end
