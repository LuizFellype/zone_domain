Rails.application.routes.draw do
  root to: 'domain_check_histories#index'

  resources :domain_check_histories
  resources :available_domains, only: :index
end
