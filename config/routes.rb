# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions, only: %i[create new]
  resource :session, only: %i[destroy]

  resources :users do
    resources :followers, controller: 'users/followers', only: %i[index]
    resources :following, controller: 'users/following', only: %i[index]
    resources :posts, controller: 'users/posts', except: %i[index new]
    resources :relationships, controller: 'users/relationships', only: %i[create destroy]
  end

  root to: 'static_pages#home'
end
