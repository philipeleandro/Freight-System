Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :companies, only: [:index, :new, :create]
  resources :cars, only: [:new, :create]
  resources :prices, only: [:new, :create]
  resources :delivery_times, only: [:new, :create]
  resources :orders, only: [:index, :create, :new, :update, :edit]
  resources :products, only: [:create, :new]
end
