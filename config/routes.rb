Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :companies, only: [:index, :new, :create]
end
