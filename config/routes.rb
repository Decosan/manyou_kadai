Rails.application.routes.draw do
  
  root to: "sessions#new"
  
  resources :users, only:[:new,:show,:create]

  resources :tasks
  
  namespace :admin do
    resources :users
  end

  resources :sessions, only:[:new,:create,:destroy]

end
