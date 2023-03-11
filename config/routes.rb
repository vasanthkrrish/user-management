Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  root to: 'users#index'
  resources :users do
    get 'info', on: :collection
  end
  namespace :api do
    namespace :v1 do
      resources :users, only: :index do
        get 'grid_data', on: :collection
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
