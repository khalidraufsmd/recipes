Rails.application.routes.draw do

  resources :recipes, only: [:index, :show]
  #default route for application will be index
  root 'recipes#index'
end
