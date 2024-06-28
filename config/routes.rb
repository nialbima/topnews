Rails.application.routes.draw do
  devise_for :users

  resource :stories

  root to: "stories#index"
end
