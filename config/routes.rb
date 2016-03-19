Rails.application.routes.draw do
  root 'pages#top'

  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # 参考: http://blog.sanojimaru.com/post/18536517802/rails3-deviseで不要なアクションへのroutesを無効にする
  devise_for :users, only: [:session, :registration, :password] do
    get '/sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    post '/sign_in', :to => 'devise/sessions#create', :as => :user_session
    delete '/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

    get '/edit', :to => 'devise/registrations#edit', :as => :edit_user_registration
    patch '/', :to => 'devise/registrations#update', :as => :edit_user_registration
    put '/', :to => 'devise/registrations#update', :as => :edit_user_registration

    post '/password', :to => 'devise/passwords#create', :as => :user_password
    get '/password', :to => 'devise/passwords#new', :as => :new_user_password
    get '/password/edit', :to => 'devise/passwords#edit', :as => :edit_user_password
    patch '/password', :to => 'devise/passwords#update', :as => :edit_user_password
    put '/password', :to => 'devise/passwords#update', :as => :edit_user_password
  end
  resources :books

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :books, constraints: {id: /\d*/}, only: [:show]
      get '/books/index_or_search', to: 'books#index_or_search'
    end
  end
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
