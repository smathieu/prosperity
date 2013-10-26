Rails.application.routes.draw do

  resources :users

  mount Prosperity::Engine => "/prosperity"
end
