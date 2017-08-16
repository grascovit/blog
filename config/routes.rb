# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions, only: %i[create new]
  resource :session, only: %i[destroy]

  resources :users do
    get 'followers', to: 'users#followers'
    get 'following', to: 'users#following'
    resources :posts, controller: 'users/posts', except: %i[index new]
    resources :relationships, controller: 'users/relationships', only: %i[create destroy]
  end

  root to: 'static_pages#home'
end
