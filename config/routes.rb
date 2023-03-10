Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations', :passwords => 'passwords'}
  root to: 'users#index'
  resources :users do
    get 'info', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
