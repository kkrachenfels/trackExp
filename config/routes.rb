Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index] do
    resources :accounts
    resources :transactions
    #resources :records

    #get 'record', on: :member, to:
    #get 'record', on: :member

  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  root 'sessions#welcome'

end
