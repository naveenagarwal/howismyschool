Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :admins
  devise_for :managers
  devise_for :school_controllers
  devise_for :teachers
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  namespace :teachers do
    get '/home' => 'home#index', as: :root
  end

  namespace :school_controllers do
    get '/home' => 'home#index', as: :root
  end

  namespace :managers do
    root 'home#index'
  end

  namespace :admins do
    root 'home#index'
  end

  resources :class_rooms
  resources :class_tests
  resources :school_controllers
  resources :teachers
  resources :subjects
  resources :students

  resources :test_results, except: [ :edit ] do
    member do
      get 'for_edit'
    end
    collection do
      get 'edit'
      get 'list'
      post 'for_edit'
    end
  end

  resources :draw_chart, only: [] do
    collection do
      get 'chart_for_latest_test_results'
    end
  end

  resources :uploaded_test_results, except: [:edit, :update]
  resources :documents, except: [:edit, :update]

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
