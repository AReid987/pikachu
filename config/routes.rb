Pikachu::Application.routes.draw do
  get "exit" => "sessions#destroy", :as => "exit"
  get "signin" => "sessions#new", :as => "signin"
  get "register" => "users#new", :as => "register"
  
  root :to => 'users#index'

  resources :sessions
  resources :users
end
