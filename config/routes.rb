Rails.application.routes.draw do
  root 'home#show'
  get '/dashboard' => 'dashboard#show'

  resources :users

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "auth0#logout"

  namespace :api do
    namespace :v1 do
      post '/credit', to: 'financial_entries#credit'
      post '/debit', to: 'financial_entries#debit'

      post '/user', to: 'users#create'

      post '/bank_account', to: 'bank_accounts#create'
    end
  end
end
