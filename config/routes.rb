Rails.application.routes.draw do
  get '/public_recipes', to: 'public_recipes#index'
  get 'home/index'
  resources :recipes
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root :to => "recipes#index", as: :authenticated_root
      get '/users/sign_out' => 'devise/sessions#destroy'
    end
    unauthenticated :user do
      root :to => "devise/sessions#new", as: :unauthenticated_root
    end
  end

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
