Congo::Application.routes.draw do

  root 'welcome#index'

  resources :products do
    resources :reviews
  end

  resources :users do
    resources :reviews
  end

  resources :categories

  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signin',  to: 'sessions#create',  via: 'post'
  match '/signout', to: 'sessions#destroy', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'


  resources :orders
  match '/cart', to: 'orders#cart', via: 'get'
  match '/add_to_cart', to: 'orders#add_to_cart', via: 'post'
  match '/update_cart', to: 'orders#update_cart', via: 'patch'
  match '/checkout', to: 'orders#checkout', via: 'get'
  match '/add_billing_info', to: 'orders#add_billing_info', via: 'patch'
  post '/confirm', to: 'orders#confirm', as: :confirm
  match '/confirmation', to: 'orders#confirmation', via: 'get'

  match '/order_fulfillment', to: 'orders#order_fulfillment', via: 'get'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
