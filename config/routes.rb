Rails.application.routes.draw do
  root  "tasks#index"
  get "/search", to: "tasks#search", as: "search_tasks"
  resources :tasks 
end
