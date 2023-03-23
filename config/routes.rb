Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "dashboard#index"

  post '/login', to: 'dashboard#login', as: 'login'

  resources :users

  namespace :api do
    namespace :v1 do
      post '/credit', to: 'financial_entries#credit'
      post '/debit', to: 'financial_entries#debit'
    end
  end
end
