# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home', to: 'static_pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    resources :posts, controller: 'users/posts', except: %i[index new]
    resources :relationships, controller: 'users/relationships', only: %i[create destroy]
  end

  root to: 'static_pages#home'
end
