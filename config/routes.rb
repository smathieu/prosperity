Prosperity::Engine.routes.draw do 
  resources :dashboards
  resources :metrics do 
    member do
      get :data
    end
  end

  resources :graphs, only: [:new, :edit, :create, :update]

  root to: 'metrics#index'
end
