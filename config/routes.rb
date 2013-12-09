Prosperity::Engine.routes.draw do 
  resources :dashboards do
    post "graphs/:graph_id", to: "dashboard_graphs#create", as: :dashboard_graphs
    delete "graphs/:graph_id", to: "dashboard_graphs#destroy"
  end
  resources :metrics do 
    member do
      get :data
    end
  end

  resources :graphs

  root to: 'metrics#index'
end
