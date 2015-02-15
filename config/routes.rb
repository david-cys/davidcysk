Kapi::Application.routes.draw do
  devise_for :users

  get 'profiles/search', :to => "profiles#search", :as => :search_profile
  resources :profiles#, :only => [:new, :edit]

  namespace :api, defaults: { format: :json } do
    resources :profiles, :only => [:show]
    post 'profiles/update', :to => 'profiles#update' # looks non-standard?
  end

  root 'home#index'
end
