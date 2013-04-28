RailsGirls::Application.routes.draw do

  get 'admin', to: 'admin#index'
  get 'about', to: 'home#about', :as => :about
  get 'blog', to: 'articles#index', :as => :blog

  resources :events do
    resources :tutors, only: [:index, :create]
    resources :girls, only: [:index, :create] do
      member do
        get 'attend'
      end
    end
    member do
      get 'pair'
      post 'import_csv'
    end
  end
  resources :articles

  root :to => 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/:provider/failure', to: 'sessions#new'
  get '/auth/:provider', to: lambda{|env| [404,{},["Not Found"]]}
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout

  # disable sign up
  #resources :users, only: [:new] do
  #  member do
  #    get :confirm
  #  end
  #end
end
