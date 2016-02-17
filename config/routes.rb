Rails.application.routes.draw do

  post 'create_user' => 'users#create', as: :create_user

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :users, except: :create do
  end

  root 'welcome#index'

end
