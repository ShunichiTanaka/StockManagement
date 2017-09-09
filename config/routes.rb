Rails.application.routes.draw do
  devise_for :users, controllers: {
		confirmations: 'users/confirmations',
		passwords: 'users/passwords',
		registrations: 'users/registrations',
		sessions: 'users/sessions',
		omiauth_callbacks: 'users/omniauth_callbacks'
	}

	resources :visualize do
	end

	resources :brands do
	end

	# brands trades stock_accoujntsはユーザが登録する場合のみ(現状)
	namespace :admin do
    root 'top#index'
    get :stock_price_to_chart, path: "brands/stock_price_to_chart", to: "brands#stock_price_to_chart", format: :json
    get :index_to_chart, path: "top/index_to_chart", to: "top#index_to_chart", format: :json
		resources :brands, param: :code, except: [:destroy]
		resource :brands, only: [:destroy]
		resources :fields
		resources :markets
    resources :tags
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
end
