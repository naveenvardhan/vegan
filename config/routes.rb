Rails.application.routes.draw do
  # mount Sidekiq::Web => "/sidekiq"

  devise_for :vendors
  # devise_for :customers
  
  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
  }

  get 'home/index'
  root "home#index"
  get "profile", to: "home#profile"
  get   "profile/edit", to: "home#edit_profile",   as: :edit_profile
  patch "profile",      to: "home#update_profile", as: :update_profile
  get "repeat_order/:id", to: "orders#repeat", as: :repeat_order

  # resources :items
  resources :cart_items, only: [:create]
  resource :cart, only: [:show]
  resources :orders, only: [:new, :create, :show]# do
  #   member do
  #     get
  #   end
  # end
  resources :addresses, only: [:new, :create]


  # resources :customers
  # resources :orders do
  #   member do
  #     get  :download
  #   end
  # end
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # /users/sign_in
  # /users/sign_out
  # /users/password/new

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :items
    resources :orders do
      member do
        get  :download
      end
    end
    resources :customers
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
