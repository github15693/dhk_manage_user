Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'users#login'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  #users controller
  post 'users/login' => 'users#login'
  get 'users/login' => 'users#login'
  get 'users/logout' => 'users#logout'
  get 'users/getRoleGrant' => 'users#getRoleGrant'
  post 'users/deleteCollection' => 'users#deleteCollection'
  get 'users/permission/:id' => 'users#permission', as: :permission
  get 'users/user_by_role/:role' => 'users#user_by_role', as: :user_by_role

  #members controller
  get 'members/show' => 'members#show'
  get 'members/profile' => 'members#profile'
  #admins controller
  get 'admins/cpn' => 'admins#cpn'


  post 'role_grants/create' => 'role_grants#create'

  get 'user_roles/getRole' => 'user_roles#getRole'

  #roles controller
  post 'roles/actionCollection' => 'roles#actionCollection'
  get 'roles/addGrant/:id' => 'roles#addGrant', as: :addGrant
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :role_grants

  resources :grants

  resources :users

  resources :user_roles

  resources :roles

  resources :members

  resources :admins

  resources :articles

  resources :emails
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
