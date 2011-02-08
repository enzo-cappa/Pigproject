Pigproject::Application.routes.draw do
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
  match '/' => 'store#index'
  match '/:controller(/:action(/:id))'
end
