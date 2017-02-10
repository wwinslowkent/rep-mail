Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :users

  resources :bills do
    resources :messages
  end

  namespace :api do
      namespace :v1 do
        resources :bills, only: [:index, :show] do
          resources :messages
        end
      end
    end
  resources :issues do
    resources :messages
  end

  resources :api, only: [:index]

  resources :representatives
end
