# frozen_string_literal: true

Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    resources :posts, controller: 'users/posts', except: %i[index new]
  end
end
