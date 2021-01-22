Rails.application.routes.draw do
  root ("home#index")
  resources :articles do
    resources :comments
  end
  resources :users, except: %i[destroy] do
    get 'follow', to: 'users#add_follower', as: 'follow'
    get 'unfollow', to: 'users#delete_follower', as: 'unfollow'
  end
  get 'signup', to: 'users#new', as: 'signup'

  resources :sessions, only: %i[new create destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
