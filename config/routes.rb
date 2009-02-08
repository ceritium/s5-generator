ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil 
  map.explore '/explore', :controller => 'main', :action => 'explore'
  map.home  '/home', :controller => 'main'

  
  #map.resources :most_commented, :controller => 'categories', :order => :comments_count, :collection => {:today => :get, :this_week => :get, :this_month => :get, :all_time => :get}
  
  
  map.resources :users do |user|
    user.resources :slideshows
  end
  
  map.resource :session
  map.resources :comments
  map.resources :categories
  
  
  map.resources :slideshows, :collection => {:drafteds => :get}, :member => {:play => :get} do |slideshow|
    slideshow.resources :slides, :collection => {:order => :put}
  end

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'main', :action => 'welcome'
  # See how all your routes lay out with "rake routes"
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  map.connect '/:order/:time', :controller => 'slideshows', :action => 'explore', :defaults => { :time => 'today' }, :requirements => { :order => /popular|most-commented/, :time => /today|this-week|this-month|all-time/ }
  #map.user '/:id', :controller => 'users', :action => 'show'
  #map.user_edit '/:id/edit', :controller => 'users', :action => 'edit'
end
