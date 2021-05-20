Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'items/index'
  root to: "items#index"
  resources :items do
    resources :records, only: [:index, :create]
    resources :comments, only: [:create, :destroy]
    resources :categories, only: :show
  end
  resources :users, only: :show
end
