Rails.application.routes.draw do
  devise_for :users, controllers: {
		confirmations: 'users/confirmations',
		passwords: 'users/passwords',
		registrations: 'users/registrations',
		sessions: 'users/sessions',
		omiauth_callbacks: 'users/omniauth_callbacks'
	}
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

	resources :visualize do
	end

	resources :brands do
	end

	# brands trades stock_accoujntsはユーザが登録する場合のみ(現状)
	namespace :admin do
    root 'top#index'
    get :stock_price_to_chart, path: "brands/stock_price_to_chart", to: "brands#stock_price_to_chart", format: :json
		resources :brands, param: :code, except: [:destroy]
		resource :brands, only: [:destroy]
		resources :fields
		resources :markets
		resources :stcok_accounts, only: [:index, :show]
		resources :stock_companies, except: [:destroy]
		resource :stock_companies, only: [:destroy]
		resources :trading_histories, except: [:destroy]
		resources :users
		resources :stock_analyses, only: [:index] do
      collection do
        post "analysis"
        post "import_index"
      end
    end
	end
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
