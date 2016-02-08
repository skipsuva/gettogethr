Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

  root 'home#index'
  get 'home/index'

  post 'votes/submit'

  post '/gatherings/:id/add-users', to: "gatherings#add_users"
  post '/gatherings/:id/mail-users', to: "gatherings#mail_users", as: "mail_users"
  post '/gatherings/:id/remove-users', to: "gatherings#remove_users", as: "remove_users"

  resources :gatherings do
    member do
      get 'autocomplete-list'
      get 'stage'
      post 'finalize'
    end
    resources :moments, only: [:create, :destroy]
    resources :activities, only: [:create, :destroy]
    resources :places, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
