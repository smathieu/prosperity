Prosperity::Engine.routes.draw do 
  resources :metrics do 
    member do
      get :data
      get :export
    end
  end

  root to: 'metrics#index'
end
