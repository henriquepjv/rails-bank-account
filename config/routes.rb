Rails.application.routes.draw do
  root 'home#show'
  get '/dashboard' => 'dashboard#show'

  resources :users
  resources :bank_accounts

  get 'oauth2/callback', to: 'authentication#callback'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'authentication#logout', as: :logout

  namespace :api do
    namespace :v1 do
      post '/credit', to: 'financial_entries#credit'
      post '/debit', to: 'financial_entries#debit'

      post '/user', to: 'users#create'

      post '/bank_account', to: 'bank_accounts#create'
    end
  end
end
