Rails.application.routes.draw do
  get 'static_pages/home'
  get '/signup', to: 'users#new'
  
  resources :users

  root 'static_pages#home'
end
