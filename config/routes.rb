require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  devise_for :users

  resources :stories, only: [:index]
  resources :flagged_stories, only: [:index]

  post "/flag", to: "flags#toggle"

  root to: "stories#index"

end
