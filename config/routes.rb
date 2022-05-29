Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :cars, only: %i[new create]
  resources :prices, only: %i[index new create]
  resources :delivery_times, only: %i[index new create]
  resources :products, only: %i[create new]

  resources :companies, only: %i[index new create] do
    get 'check_price', on: :collection
  end

  resources :orders, only: %i[index create new update edit] do
    get 'search', on: :collection
  end
end
