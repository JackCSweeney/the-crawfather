Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'welcome#index'
  post '/login', to: 'welcome#login'
  delete '/logout', to: 'welcome#logout'
  get '/users/new', to: 'users#new'
  post '/users', to: 'users#create'
  get '/home', to: 'users#show'
  get '/dashboard', to: 'users#dashboard'
end
