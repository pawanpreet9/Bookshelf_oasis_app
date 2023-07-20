Rails.application.routes.draw do
  get 'genres/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'

  get 'contact', to: 'contact#show'
  get 'about', to: 'about#show'
  resources :books, only: [:index, :show]
  resources :genres, only: [:index, :show]
  namespace :admin do
    resources :books
    resources :order_line_items
  end
end
