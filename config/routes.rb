SkiRental::Application.routes.draw do

  root :to => "dashboard#home"
  devise_for :stores
  match 'dashboard/main' => "dashboard#main", :as => "store_root"
  # match 'rentals/checkout/:package_id' => "rentals#checkout", :as => "checkout"
  match 'rentals/:package_id/checkout' => "rentals#checkout", :as => "checkout"
  match 'rentals/:package_id/checkin' => "rentals#checkin", :as => "checkin"  
  # http://stackoverflow.com/questions/9139901/cant-trigger-this-controller-action-in-a-view-it-isnt-a-default-rails-restful
  # get 'rentals/:id/checkout' => 'rentals#checkout', as: 'checkout2'
  
  resources :customers do 
    resources :packages do
      resources :rentals
    end
  end
  
  resources :packages do
    resources :rentals
  end
  
  resources :customers
  resources :packages
  resources :plans
  resources :skis
  resources :boots
  resources :rentals
  resources :boot_sizes
  resources :ski_sizes  
  
  match ':controller(/:action(/:id(.:format)))'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
