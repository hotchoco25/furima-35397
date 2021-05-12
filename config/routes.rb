Rails.application.routes.draw do
  resources :users, only: :show
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :items do
    resources :records, only: [:index, :create]
    resources :comments, only: [:create, :destroy]
  end
end
