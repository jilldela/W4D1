Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :update, :destroy, :create]
  resources :artworks, only: [:show, :update, :destroy, :create]
  resources :artwork_shares, only: [:destroy, :create]
  resources :users, only: [:show] do
    resources :artworks, only: [:index]
  end
  # get 'users', to: 'users#index', :as => 'users_index'
  # post 'users', to: 'users#create'
  # get 'users/new', to: 'users#new', :as => 'new_users'
  # get 'users/:id', to: 'users#edit', :as => 'edit_users'
  # get 'users/:id', to: 'users#show'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'
end
