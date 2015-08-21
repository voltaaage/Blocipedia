Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'

  resources :wikis do 
    resources :collaborators, only: [:create, :destroy]
  resources :charges, only: [:new, :create]
  
  resources :users, only: [:update] 
    post :downgrade
    post :upgrade
  end

end
