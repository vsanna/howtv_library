Rails.application.routes.draw do
  root 'pages#top'

  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # 参考: http://blog.sanojimaru.com/post/18536517802/rails3-deviseで不要なアクションへのroutesを無効にする
  devise_scope :user do
    get '/sign_in', :to => 'users/sessions#new'
    post '/sign_in', :to => 'users/sessions#create'
    get '/sign_out', :to => 'users/sessions#destroy'

    get '/passwords/edit', :to => 'users/registrations#edit'
    patch '/passwords/update', :to => 'users/registrations#update'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    # passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  resources :books
  get '/mypage', to: 'pages#mypage'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :books, constraints: {id: /\d*/}, only: [:show]
      get '/books/index_or_search', to: 'books#index_or_search'
      post '/books/:id/borrow', to: 'books#borrow'
      post '/books/:id/return', to: 'books#return'
      post '/request', to: 'requests#create'
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
