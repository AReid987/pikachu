Pikachu::Application.routes.draw do
  
  resources :admins do
    collection do
      post :sort
    end
  end
  
  resources :users do
  	collection do
  		post :sort
  	end
  end

  resources :sessions
	get "signout" => "sessions#destroy", :as => "signout"
	get "signin" => "sessions#new", :as => "signin"
	get "register" => "users#new", :as => "register"
  
  root :to => "users#new"

end