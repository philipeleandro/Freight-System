Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :companies, only: [:index, :new, :create]
  resources :cars, only: [:new, :create]
end
