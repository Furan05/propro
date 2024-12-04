Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route pour vérifier la santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour les utilisateurs
  # Routes pour les catégories
  resources :categories

  resources :users


  # Routes pour les DaddyServices
  resources :daddy_services do
    member do
      get 'available_slots'
      patch 'associate_service', to: 'categories#update'
    end
    collection do
      get :search
    end
    resources :appointments, only: [:create]
  end

  # Routes pour les rendez-vous
  resources :appointments, only: [:index]
end
