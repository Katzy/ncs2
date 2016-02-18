Rails.application.routes.draw do

  post 'create_user' => 'users#create', as: :create_user

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :users, except: :create

  resources :leagues do
    resources :schools, controller: "leagues/schools"
      member do
        delete :delete_school
      end
  end

  resources :schools do
    resources :wrestlers, controller: "schools/wrestlers"
  end


  # resources :alerts


  resources :wrestlers, only: [:index, :edit, :show, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  root 'welcome#index'

end
