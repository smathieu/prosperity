Prosperity::Engine.routes.draw do 
  resources :dashboards
  resources :metrics do 
    member do
      get :data
    end
  end

  root to: 'metrics#index'
end
