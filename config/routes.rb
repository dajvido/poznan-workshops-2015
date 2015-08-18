Rails.application.routes.draw do
  devise_for :users
  root to: 'visitors#index'

  resources :students do
    get :subjects
  end
end
