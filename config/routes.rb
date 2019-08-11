Rails.application.routes.draw do
  
  root to: "sessions#new"
  
  resources :tasks

  resources :users, only:[:show,:new,:create]

  resources :sessions, only:[:new,:create,:destroy]
  
end
