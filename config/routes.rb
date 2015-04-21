Batterypopv2::Application.routes.draw do


  get 'kpass/authorize' => 'kpass#authorize', as: 'kpass_authorize'
  get 'kpass/profile' => 'kpass#profile', as: 'kpass_profile'
  get 'kpass/verify' => 'kpass#verify', as: 'kpass_verify'
  get 'kpass/sign_out' => 'kpass#sign_out', as: 'kpass_sign_out'
  post 'kpass/webhooks' => 'kpass#webhooks', as: 'kpass_webhooks'
  get 'kpass/new' => 'kpass#new', as: 'kpass_new'


  mount Rich::Engine => '/rich', :as => 'rich'

  resources :channels

  resources :menus

  # resources :contacts
  #

  # mount Split::Dashboard, :at => 'admin/split'

  resources :friends do
    member do
      get :follow
      get :unfollow
    end
    resources :episodes
  end

  # resources :episodes

  resources :posts

  resources :links do
    member do
      get :file
      get :feed
    end
  end

  resources :categories

  resources :tournaments

  get "matches/:id/:episode_id", :to => "tournaments#vote"

  resources :shows do
    member do
      get :follow
      get :unfollow
    end
     resources :episodes
  end

  resources :episodes do
    member do
      get :pop
      get :unpop
      post :refresh
    end
  end

 post "/refresh", :to => "episodes#refresh"

  resources :messages
  resources :conversations


  # sitemap routing
  get "/sitemap.xml", :to => "sitemap#index"
  get "/sitemap.xml.gz", :to => "sitemap#index"

  get 'videotest', :to => "media#index"

  get "/dashboard", :to => "creators#dashboard"
  get "/creators/sign_out", :to => "creators#dashboard"


  # get "pages/search"

  get "shorts", :to => "pages#shorts"
  # get "calling-all-creators", :to => "pages#creators"
  # get "privacy-policy", :to => "pages#privacy"
  # get "terms-and-conditions", :to => "pages#terms"
  # get "advertise-with-us", :to => "pages#advertise"
  # get "about-batterypop", :to => "pages#about"
  # get "investors", :to => "pages#investors"
  get "bot", :to => "pages#bot"

  # get "test", :to => "pages#test"

  get "search", :to => "pages#search"

  get "contact", :to => "contacts#new"
  post "contact", :to => "contacts#create"

  root :to => "pages#home"




  devise_for :users,
    :controllers => {
      :registrations => "devise/custom/registrations",
      :passwords => "devise/custom/passwords",
      :sessions => "devise/custom/users"
    }

  devise_for :creators,
    :controllers => {
       sessions: "devise/custom/creators"
      # :registrations => "devise/custom/creators"
    }

  # devise_for :creators, :skip => [:sessions] do
  #   get '/creator/login' => 'devise/sessions#new', :as => :new_creator_session
  #   post '/creator/login' => 'devise/sessions#create', :as => :creator_session
  #   get 'logout' => 'devise/sessions#destroy', :as => :destroy_creator_session
  # end

    #devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

resources :users do
    member do
      patch :save_avatar
      get :follow
      get :unfollow
     end
  end

  resources :creators  do
    member do
      post :draw_chart_bar
      post :draw_chart_donut
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  get ":id" => "pages#show"

  get '*path' => redirect('/')



end
