Rails.application.routes.draw do
  devise_for :users


  resources :stories, only: [:index]
  resources :flagged_stories, only: [:index]

  post "/flag", to: "flags#toggle"

  root to: "stories#index"

end
