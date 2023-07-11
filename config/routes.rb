Rails.application.routes.draw do
  root 'home#home'

  namespace :doctors do
    resources :sessions, only: [:new, :create, :destroy] # for doctors login/logout
    resources :registrations, only: [:new, :create] # for doctors signup
    delete 'logout', to: 'sessions#destroy', as: 'logout' # added line
  end
  
  namespace :patients do
    resources :sessions, only: [:new, :create, :destroy] # for patients login/logout
    resources :registrations, only: [:new, :create] # for patients signup
    delete 'logout', to: 'sessions#destroy', as: 'logout' # added line
  end

  resources :patients do
    resources :appointments, only: [:new, :create, :show, :destroy]
    resources :medications, only: [:index, :create]
    resources :diagnoses, only: [:index, :create]
  end

  resources :doctors do
    resources :patients, only: [:new, :create, :show]
    resources :appointments, only: [:index, :create]
  end
end
