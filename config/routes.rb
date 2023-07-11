Rails.application.routes.draw do
  root 'home#home'

  namespace :doctors do
    resources :sessions, only: [:new, :create, :destroy] # for doctors login/logout
    resources :registrations, only: [:new, :create] # for doctors signup
    delete 'logout', to: 'sessions#destroy', as: 'logout' 
  end
  
  namespace :patients do
    resources :sessions, only: [:new, :create, :destroy] # for patients login/logout
    resources :registrations, only: [:new, :create] # for patients signup
    delete 'logout', to: 'sessions#destroy', as: 'logout' 
  end

  resources :patients do
    resources :appointments, only: [:new, :create, :show, :destroy]
    resources :medications, only: [:index, :create]
    resources :diagnoses, only: [:index, :create]
  end

  resources :doctors, except: [:show] do
    resources :patients, only: [:new, :create, :show]
    resources :appointments, only: [:index, :create]
  end
  get 'dashboard', to: 'patients#dashboard', as: 'dashboard'
  get 'doctors/:id/daily_patients', to: 'doctors#daily_patients', as: 'daily_patients_doctor'

end
