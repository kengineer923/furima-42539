Rails.application.routes.draw do
  root to: 'items#index'
  get 'posts', to: 'posts#index'
  devise_for :users
end
