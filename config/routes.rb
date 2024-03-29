Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get '/search', to: 'tasks#search'
    end  
  end

  resources :sessions, only: [:new, :create, :destroy]

 resources :users, only: [:new, :create, :show, :update, :destroy, :edit]

  namespace :admin do
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy, :update]  
  end
   resources :sessions, only: [:new, :create, :destroy]
   resources :labels, only: [:index, :new, :edit, :create, :destroy, :update]
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'  
end
