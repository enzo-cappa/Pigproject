PigProject::Application.routes.draw do
  get "test/index"

  resources :prices
  match 'deposit/amount_by_user' => 'deposits#amount_by_user'
  resources :deposits
  resources :users do
    resources :orders, :deposits
  end
  resources :line_items
  resources :orders
  resources :products
  resources :administrators

  match '/:controller(/:action(/:id))'
  
  get "/store/index"  
  match '/' => 'store#index'    
  
  
end
