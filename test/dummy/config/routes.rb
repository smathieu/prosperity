Rails.application.routes.draw do
  resources :users
  mount Prosperity::Engine => "/prosperity"

  root to: redirect("/prosperity")
end
