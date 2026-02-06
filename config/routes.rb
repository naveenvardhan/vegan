Rails.application.routes.draw do
  # mount Sidekiq::Web => "/sidekiq"

  devise_for :vendors
  # devise_for :customers
  
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }

  get 'home/index'
  root "home#index"
  # resources :items
  resources :cart_items, only: [:create]
  resource :cart, only: [:show]
  resources :orders, only: [:new, :create, :show]

  # resources :customers
  # resources :orders do
  #   member do
  #     get  :download
  #   end
  # end
  
  namespace :admin do
    resources :items
    resources :orders do
      member do
        get  :download
      end
    end
    resources :customers
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
