Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route pour vérifier la santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour les utilisateurs
  resources :users, only: [:index, :show]

  # Routes pour les catégories
  resources :categories do
    resources :daddy_services, only: [:index, :new, :create]
    member do
      patch 'associate_service', to: 'categories#update'
    end
  end

  # Routes pour les DaddyServices
  resources :daddy_services, only: [:show, :edit, :update, :destroy]
end
