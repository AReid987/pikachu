Pikachu::Application.routes.draw do
  resources :admins
  resources :users

  resources :sessions
	get "signout" => "sessions#destroy", :as => "signout"
	get "signin" => "sessions#new", :as => "signin"
	get "register" => "users#new", :as => "register"
  
  root :to => 'users#new'
  resources :sessions

end