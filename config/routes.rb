Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#index'

  resources :students do
    get :subjects
  end

  resources :teachers do
    get :subjects
  end

  get 'reports/subjects', to: 'reports#subjects', as: 'report_subjects'
end
