Ubiquity::Application.routes.draw do
  
 
  resources :roles


  resources :geo_locations


  resources :statuses


  resources :friendships


  resources :transports


  resources :transport_types


  resources :authentications
  
  resources :android_api do
    collection do 
      get :android_connect_user
      get :android_create_trip
      get :android_destroy_trip
      get :android_stream_geo
      get :busses_nearby
    end
  end

  resources :myprofile do
    collection do
      match :update
    end
  end    

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/profile', to: 'users#show'
  get '/users', to: 'users#index'
  post '/users/:id/add_friend', to: 'users#add_friend'
  delete '/users/:id/remove_friend', to: 'users#remove_friend'

  # match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'sessions#destroy', as: 'signout'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'
  match 'fetch_bus' => 'welcome#fetch_bus'
  match '/about' => 'welcome#about'
  match '/editprofile' => 'myprofile#edit'
  match '/my_travel_history' => 'myprofile#my_travel_history'
  match '/build_history/:id' => 'myprofile#build_history'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
