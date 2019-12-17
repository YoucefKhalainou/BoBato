Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, path: '', path_names: { sign_in: 'connexion', sign_out: 'deconnexion', password: 'mot_de_passe', sign_up: 'inscription', edit: 'parametres'}
  root 'home#index'
  
  resources :user do
    resources :my_convoys, only: [:index, :show], :path => "mes_convoyages"
    resources :submissions, only: [:index], :path => "mes_candidatures"
  end

  resources :home, only: [:index]

  resources :convoys, :path => "convoyages" do
  	resources :pictures
  end

  resources :deliveries, :path => "convoyages_confirme"
  resources :charges, :path => "paiement"
  resources :submissions, only: [:create, :destroy]

  resources :profiles, :path => "mon_profil" do
    resources :avatars, only: [:create]
  end

  resources :comments, :path => "commentaires"

  # Custom error pages
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#server_errors'

end
