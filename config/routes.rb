Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :cars, only: [:new, :create]
  resources :prices, only: [:index, :new, :create]
  resources :delivery_times, only: [:index, :new, :create]
  resources :products, only: [:create, :new]
  
  resources :companies, only: [:index, :new, :create] do
    get 'check_price', on: :collection
  end

  resources :orders, only: [:index, :create, :new, :update, :edit] do
    get 'search', on: :collection
  end
end
