Rails.application.routes.draw do
  root ("home#index")
  resources :articles do
    resources :comments
  end
  resources :users, only: %i[new create edit update]
  get 'signup', to: 'users#new', as: 'signup'

  resources :sessions, only: %i[new create destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
