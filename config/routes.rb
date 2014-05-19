Hummingbird::Application.routes.draw do
  get "source_files/new"
  get "source_files/create"
  get "source_files/index"
  root 'projects#index'
  get "reports/index"
  post '/projects/start_test' => "projects#start_test"
  post '/projects/start_test_by_tag' => "projects#start_test_by_tag"
  get "reports/write_report"
  post "reports/delete_selected_reports" => "reports#delete_selected_reports"
  get "source_files/refresh_source_files" => "source_files#refresh_source_files", as: :refresh_source_files
  get '/reports/:id/show_report' => "reports#show_report"

  resources :projects do 
    resources :reports
    resources :source_files
    resources :settings
  end
  get '/projects/:id/:tag' => "projects#filter_by_tag", as: :filter_by_tag

  resources :reports
  resources :source_files
  resources :settings
  
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
