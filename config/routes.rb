Prosperity::Engine.routes.draw do 
  resources :metrics do 
    member do
      get :data
    end
  end

  root to: 'metrics#index'
end
