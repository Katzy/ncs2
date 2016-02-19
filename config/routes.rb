Rails.application.routes.draw do
  get 'wrestlers/weight_106' => 'wrestlers#weight_106'

  get 'wrestlers/weight_113' => 'wrestlers#weight_113'

  get 'wrestlers/weight_120' => 'wrestlers#weight_120'

  get 'wrestlers/weight_126' => 'wrestlers#weight_126'

  get 'wrestlers/weight_132' => 'wrestlers#weight_132'

  get 'wrestlers/weight_138' => 'wrestlers#weight_138'

  get 'wrestlers/weight_145' => 'wrestlers#weight_145'

  get 'wrestlers/weight_152' => 'wrestlers#weight_152'

  get 'wrestlers/weight_160' => 'wrestlers#weight_160'

  get 'wrestlers/weight_170' => 'wrestlers#weight_170'

  get 'wrestlers/weight_182' => 'wrestlers#weight_182'

  get 'wrestlers/weight_195' => 'wrestlers#weight_195'

  get 'wrestlers/weight_220' => 'wrestlers#weight_220'

  get 'wrestlers/weight_285' => 'wrestlers#weight_285'

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
  resources :tournaments

  resources :wrestlers do
    collection do
      delete 'destroy_all'
    end
  end

    root 'welcome#index'

end
