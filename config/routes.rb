Rails.application.routes.draw do

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

  resources :orders, only: [:new, :create, :show]


  resources :cart_items, only: [:create, :update, :destroy, :index]
  resources :books, only: [:index, :show]
  resources :genres, only: [:index, :show]
  namespace :admin_users do
    resources :books
    resources :order_line_items


  end


  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
  }
  devise_scope :customer do
    get 'customers/profile', to: 'customers/registrations#show', as: :customer_profile
    patch 'customers/add_address', to: 'customers/registrations#add_address', as: :add_address
  # patch 'registration/add_address', to: 'registrations#add_address', as: :add_address
  end



end
