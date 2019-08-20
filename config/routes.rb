Rails.application.routes.draw do
  
  root to: "sessions#new"
  
  resources :users, only:[:new,:show,:create]

  resources :tasks
  
  namespace :admin do
    resources :users
  end

  resources :sessions, only:[:new,:create,:destroy]

  resources :groups

  resources :user_groups, only:[:create,:destroy]

end
