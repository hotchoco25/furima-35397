Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resorces :items, only: :index
end
