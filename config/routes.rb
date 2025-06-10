Rails.application.routes.draw do
  resources :items, only: [:index, :new, :create, :show]
  root to: 'items#index'
  devise_for :users
end
