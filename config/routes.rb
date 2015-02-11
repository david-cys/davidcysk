Kapi::Application.routes.draw do
  devise_for :users

  resources :profiles#, :only => [:new, :edit]

  root 'home#index'
end
