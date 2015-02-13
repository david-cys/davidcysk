Kapi::Application.routes.draw do
  devise_for :users

  get 'profiles/search', :to => "profiles#search", :as => :search_profile
  resources :profiles#, :only => [:new, :edit]

  root 'home#index'
end
