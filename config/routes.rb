Rails.application.routes.draw do
  devise_for :customers
  get 'genres/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  get 'books_on_sale', to: 'books#books_on_sale'
  get 'recently_updated_books', to: 'books#recently_updated_books'
  get 'new_books', to: 'books#new_books'
  get 'contact', to: 'contact#show'
  get 'about', to: 'about#show'
  get 'shopping_cart', to: 'cart_items#index'
  post 'shopping_cart', to: 'cart_items#create', as: 'add_to_cart'
  resources :cart_items, only: [:create, :update, :destroy]
  resources :books, only: [:index, :show]
  resources :genres, only: [:index, :show]
  namespace :admin_users do
    resources :books
    resources :order_line_items


  end
end
