Rails.application.routes.draw do
  get 'static_pages/home'
  get '/signup', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  
  resources :users
  resources :posts
  resources :categories
  resources :subscriptions, only: [:create, :destroy, :index]

  root 'static_pages#home'
end
