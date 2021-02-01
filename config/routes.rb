Rails.application.routes.draw do
  devise_for :users
  root 'dashboards#index'

  resources :teams
  resources :games
  resources :scores
end
