# frozen_string_literal: true

Rails.application.routes.draw do
  # Devise routes for admin_users and ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'home#index'

  # Custom routes
  get 'books_on_sale', to: 'books#books_on_sale'
  get 'recently_updated_books', to: 'books#recently_updated_books'
  get 'new_books', to: 'books#new_books'
  get 'contact', to: 'contact#show'
  get 'about', to: 'about#show'
  get 'shopping_cart', to: 'cart_items#index'
  post 'shopping_cart', to: 'cart_items#create', as: 'add_to_cart'

  # Order routes
  resources :orders, only: %i[new create show]

  # Cart item routes
  resources :cart_items, only: %i[create update destroy index]

  # Book and genre routes
  resources :books, only: %i[index show]
  resources :genres, only: %i[index show]

  # Admin users namespace
  namespace :admin_users do
    resources :books
    resources :order_items
  end

  # Devise routes for customers
  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
  }

  # Custom devise routes for customers
  devise_scope :customer do
    get 'customers/profile', to: 'customers/registrations#show', as: :customer_profile
    patch 'customers/add_address', to: 'customers/registrations#add_address', as: :add_address
  end
end
