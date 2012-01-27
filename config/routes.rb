PigProject::Application.routes.draw do  
  scope "(:locale)", :locale => /en|es/ do
    
    resources :prices    
    resources :deposits
    resources :users do
      resources :orders, :deposits
    end
    resources :line_items
    resources :orders
    resources :products
    resources :administrators
    match '/:controller(/:action(/:id))'          
  end
  #match 'deposit/amount_by_user' => 'deposits#amount_by_user'
  
  
  match "/:locale" => 'store#index'  
  root :to => 'store#index'     
end
