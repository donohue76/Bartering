Rails.application.routes.draw do
  get '/accept' => 'barters#accept'
  # resources :comments
  # devise_for :users, path_names: {login: "login", logout: "logout"}

  devise_for :users

  # :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users
  # resources :barters

  post 'comments/:id/accept' => 'comments#accept'
  post 'comments/:id/decline' => 'comments#decline'

  resources :barters do
    resources :comments do
      collection do
        #post '/accept/:id' => :accept, as: 'comment_accept'
        # post '/decline/:id' => :decline, as: 'comment_decline'
      end
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/landing' => 'barters#landing'
  get '/goods' => 'barters#goods'
  get '/services' => 'barters#services'
  get '/barters' => 'barter#barters'
  get '/hillcrest' => 'barters#hillcrest'
  get '/north_park' => 'barters#north_park'
  get '/kensington' => 'barters#kensington'
  get '/university_heights' => 'barters#university_heights'
  get '/little_italy' => 'barters#little_italy'
  get '/selection' => 'barters#select'
  get '/profile' => 'users#profile'
  get '/unauthorized' => 'user#unauthorized'
  
  # You can have the root of your site routed with "root"
  # root 'barter#landing'
  root 'barters#landing'
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
