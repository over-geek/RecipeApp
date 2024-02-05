Rails.application.routes.draw do
  get 'home/index'
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    member do
      patch 'toggle'
    end
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :foods

  resources :recipes do
    member do
      get 'show_for_purpose1'
    end
  end
  
  get 'public_recipes', to: 'recipes#public_recipes', as: :public_recipes

  get 'general_list', to: 'general_list#index'
end
