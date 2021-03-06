Rails.application.routes.draw do

  get 'compare/index'

  resources :comments

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

  get '/' => 'home#index', as: :guests_root

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

  resources :class_rooms do
    member do
      get 'complete_test_results'
    end
  end

  resources :class_tests
  resources :school_controllers
  resources :teachers
  resources :subjects
  resources :students

  resources :test_results, except: [:edit] do
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
    member do
      get 'chart_for_class_room'
      get 'chart_for_class_room_toppers_subjectwise'
      get 'chart_for_class_room_toppers_testwise'
      get 'chart_for_class_room_lowest_scorers_testwise'
      get 'class_room_tests_pass_fail_details/:class_test_id' => 'draw_chart#class_room_tests_pass_fail_details'

      get 'class_test_toppers'
      get 'class_test_lowest_scorers'
      get 'class_test_subjectwise_toppers'
      get 'class_test_subjectwise_lowest_scorers'

      get 'subject_toppers'
      get 'subject_lowest_scorers'

      get 'student_toppers'
      get 'student_lowest_scorers'
      get 'student_overall_performance'
      get 'tests_score'
      get 'subjects_score'
      get 'subjects_yearwise_score'
    end
    collection do
      get 'class_test_full_test_result/:id/:class_test_id' => 'draw_chart#class_test_full_test_result'
      get 'chart_for_latest_test_results'
    end
  end

  resources :uploaded_test_results, except: [:edit, :update]
  resources :documents, except: [:edit, :update]

  resources :search, only: [:index, :create, :show]

  get 'my_account' => 'my_accounts#index'
  get 'my_account/more_details' => 'my_accounts#more_details'
  get 'my_account/edit' => 'my_accounts#edit'
  patch 'my_account/update' => 'my_accounts#update'
  put 'my_account/update' => 'my_accounts#update'

  resources :schedules do
    collection do
      get 'list'
      get 'day_events'
    end
  end

  resources :mock_tests do
    collection do
      get 'add_question/:count' => 'mock_tests#add_question', as: :add_question
    end
  end

  resources :look_ups, only: [:index] do
    collection do
      post 'show' => 'look_ups#show', as: :show
      get 'class_room_students'
    end
  end

  resources :compare, only: [:index] do
    collection do
      post 'show' => 'compare#show', as: :show
      get 'class_room_students'
    end
  end

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
