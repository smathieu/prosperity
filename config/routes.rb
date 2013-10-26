Prosperity::Engine.routes.draw do
  resources :metrics

  root to: 'metrics#index'
end
