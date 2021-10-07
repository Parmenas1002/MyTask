Rails.application.routes.draw do
  root  "tasks#index"
  resources :tasks 
  resources :users, only:  %i[new create show]
  resources :sessions, only: %i[new create destroy]

  namespace :admin do
    resources :users
    resources :tags
  end
end
