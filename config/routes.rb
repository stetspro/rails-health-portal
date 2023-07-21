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
    resources :appointments, only: [:new, :create, :show, :destroy] do
      resources :patient_diagnoses, only: [:new, :create]  
      collection do
        get :choose_time
        post :finalize
      end
    end
    resources :medications, only: [:index, :create]
    resources :diagnoses, only: [:index, :create]
  end
  

  resources :doctors, except: [:show] do
    resources :patients, only: [:new, :create, :show]
    resources :appointments, only: [:index, :create]
  end
  
  get 'dashboard', to: 'patients#dashboard', as: 'dashboard'
  get 'doctors/:id/daily_patients', to: 'doctors#daily_patients', as: 'daily_patients_doctor'
  post '/diagnosticForm/:patient_id', to: 'patient_diagnoses#create', as: 'diagnostic_form'
  get '/diagnosticForm/:patient_id/new', to: 'patient_diagnoses#new', as: 'new_patient_diagnosis'
  get '/diagnosis/:id/scheduler', to: 'patient_diagnoses#scheduler', as: 'scheduler_patient_diagnosis'
  post '/diagnosis/:id/confirm_schedule', to: 'patient_diagnoses#confirm_schedule', as: 'confirm_schedule_patient_diagnosis'
end
