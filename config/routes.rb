Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "dashboard#index"

  post '/login', to: 'dashboard#login', as: 'login'

  resources :users
end
