Lfi::Application.routes.draw do

  
  root :to => 'main#images'

  # actions
  match 'start_scanning' => 'main#start_scanning'
  match 'start_updating_orders' => 'main#start_updating_orders'
  match 'start_updating_order/:id' => 'main#start_updating_order'
  match 'start_copy_order/:order_id/:copy_target_id' => 'main#start_copy_order'

  # pages
  match 'conf' => 'main#conf'
  match 'orders' => 'main#orders'
  match 'order/:id' => 'main#order'
  match 'stats' => 'stats#index'
  match 'images' => 'main#images'
  match 'image/:id' => 'main#image_detail'
  match 'show_image/:id' => 'main#show_image'

  # json services
  match 'image_search' => 'main#image_search'
  match 'image_search/:limit/:searchterm' => 'search#image_search'
  match 'order_search' => 'main#order_search'
  match 'order_search/:limit/:searchterm' => 'search#order_search'
  match 'sidekiq_queue_jobcount' => 'main#sidekiq_queue_jobcount'

  # resources
  resources :scan_paths
  resources :copy_targets
  
  # sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

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
  # root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
