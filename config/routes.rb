Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :users

  resources :bills do
    resources :messages
  end

  resources :issues do
    resources :messages
  end

  resources :representatives
end
