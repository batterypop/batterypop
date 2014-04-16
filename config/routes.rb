Batterypopv2::Application.routes.draw do

  mount Rich::Engine => '/rich', :as => 'rich'
  
  resources :channels


  # resources :contacts

  resources :friends do
    resources :episodes
  end

  # resources :episodes

  resources :posts
  
  resources :categories

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



  get "/dashboard", :to => "creators#dashboard"
    # get "/creators/dashboard", :to => "creators#dashboard"

#attempt at voting on episode not within shows nesting
# put '/episodes/:id/:action' => 'episodes#popunpop'


# put '/shows/:id/:action' => 'shows#followToggle'

  # get "pages/home"
  # get "pages/contact"
  # get "pages/about"
  # get "pages/newest"
  # get "pages/shorts"
  # get "pages/creators"
  # get "pages/privacy"
  # get "pages/terms"
  # get "pages/advertise"
  # get "pages/search"

  get "shorts", :to => "pages#shorts"
  get "calling-all-creators", :to => "pages#creators"
  get "privacy-policy", :to => "pages#privacy"
  get "terms-and-conditions", :to => "pages#terms"
  get "advertise-with-us", :to => "pages#advertise"
  get "about-batterypop", :to => "pages#about"
  get "investors", :to => "pages#investors"
  
  get "search", :to => "pages#search"

  get "contact", :to => "contacts#new"
  post "contact", :to => "contacts#create"
 
  root :to => "pages#home"


  # resources :users do
  #   member do
  #     get :follow
  #     get :unfollow
  #   end
  # end

  devise_for :users,
    :controllers => { 
      :registrations => "devise/custom/registrations", 
      :passwords => "devise/custom/passwords" 
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
      get :follow
      get :unfollow
     end
  end

  resources :creators  
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)



  get '*path' => redirect('/')
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
