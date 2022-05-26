Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :companies, only: [:index, :new, :create]
  resources :cars, only: [:new, :create]
  resources :prices, only: [:new, :create]
  resources :delivery_times, only: [:new, :create]
  resources :products, only: [:create, :new]
  
  
  resources :orders, only: [:index, :create, :new, :update, :edit] do
    get 'search', on: :collection
  end
end
