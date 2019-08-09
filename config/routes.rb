Rails.application.routes.draw do
  
  root to: "users#new"
  
  resources :tasks

  resources :users, only:[:show,:new,:create]
  
end
