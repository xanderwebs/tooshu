Tooshu::Application.routes.draw do
  
  
  # get "users/edit"

  # get "users/update"

  get "users/books"

  get "books/index"

  get "users/requests"

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
  
  root :to => 'users#home'
  
  match 'login' => 'login#login'
  match 'login_post' => 'login#login_post'
  match 'logout' => 'login#logout'
  
  match 'books/newBooksSearch' => 'books#newBooksSearch'
  match 'books/removeModal' => 'books#get_remove_modal'
  match 'books/remove' => 'books#remove'

  match 'bookshelf' => 'bookshelf#get_requests'
  match 'bookshelf/modal' => 'bookshelf#get_modal'

  match 'search/searchBarSearch' => 'search#searchBarSearch'
  
  match 'requests/modal' => 'requests#get_modal'  
  match 'requests/acceptRejectModal' => 'requests#get_accept_reject_modal'
  match 'requests/accept' => 'requests#accept', :via => [:post]
  match 'requests/reject' => 'requests#reject'
  match 'requests/send' => 'requests#send_message'
  match 'requests/messengerModal' => 'requests#get_messenger_modal'
  match 'requests/returnedModal' => 'requests#get_returned_modal'
  match 'requests/returned' => 'requests#returned', :via => [:post]

  match 'locations/modal' => 'locations#get_modal'  

  match 'about' => 'info#about'
  
  resources :users
  resources :books
  resources :checkouts
  resources :requests
  resources :locations
  resources :favorites
  resources :application_feedback
  
  
end
