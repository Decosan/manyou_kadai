Rails.application.routes.draw do
  
  root to: "sessions#new"
  
  resources :users, only:[:new,:show,:create,:edit,:update] do
    member do
      get :anaylsis
    end
  end

  resources :tasks
  
  namespace :admin do
    resources :users
  end

  resources :sessions, only:[:new,:create,:destroy]

  resources :groups

  resources :user_groups, only:[:create,:destroy]

  resources :labels, only:[:new,:create,:edit,:update,:destroy]

end
