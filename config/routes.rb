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

  get 'information/alerts' => 'information#alerts'

  get 'information/schedule' => 'information#schedule'

  get 'information/seeds' => 'information#seeds'

  get 'information/help' => 'information#help'

  get 'users/all_teams_no_entry' => 'users#all_teams_no_entry', action:  'all_teams_no_entry'

  get 'cellnumbers/send_alert_106' => 'cellnumbers#send_alert_106', action: 'send_alert_106'

  get 'cellnumbers/send_alert_106_cons' => 'cellnumbers#send_alert_106_cons', action: 'send_alert_106_cons'

  get 'cellnumbers/send_alert_113' => 'cellnumbers#send_alert_113', action: 'send_alert_113'

  get 'cellnumbers/send_alert_113_cons' => 'cellnumbers#send_alert_113_cons', action: 'send_alert_113_cons'

  get 'cellnumbers/send_alert_120' => 'cellnumbers#send_alert_120', action: 'send_alert_120'

  get 'cellnumbers/send_alert_120_cons' => 'cellnumbers#send_alert_120_cons', action: 'send_alert_120_cons'

  get 'cellnumbers/send_alert_126' => 'cellnumbers#send_alert_126', action: 'send_alert_126'

  get 'cellnumbers/send_alert_126_cons' => 'cellnumbers#send_alert_126_cons', action: 'send_alert_126_cons'

  get 'cellnumbers/send_alert_132' => 'cellnumbers#send_alert_132', action: 'send_alert_132'

  get 'cellnumbers/send_alert_132_cons' => 'cellnumbers#send_alert_132_cons', action: 'send_alert_132_cons'

  get 'cellnumbers/send_alert_138' => 'cellnumbers#send_alert_138', action: 'send_alert_138'

  get 'cellnumbers/send_alert_138_cons' => 'cellnumbers#send_alert_138_cons', action: 'send_alert_138_cons'

  get 'cellnumbers/send_alert_145' => 'cellnumbers#send_alert_145', action: 'send_alert_145'

  get 'cellnumbers/send_alert_145_cons' => 'cellnumbers#send_alert_145_cons', action: 'send_alert_145_cons'

  get 'cellnumbers/send_alert_152' => 'cellnumbers#send_alert_152', action: 'send_alert_152'

  get 'cellnumbers/send_alert_152_cons' => 'cellnumbers#send_alert_152_cons', action: 'send_alert_152_cons'

  get 'cellnumbers/send_alert_160' => 'cellnumbers#send_alert_160', action: 'send_alert_160'

  get 'cellnumbers/send_alert_160_cons' => 'cellnumbers#send_alert_160_cons', action: 'send_alert_160_cons'

  get 'cellnumbers/send_alert_170' => 'cellnumbers#send_alert_170', action: 'send_alert_170'

  get 'cellnumbers/send_alert_170_cons' => 'cellnumbers#send_alert_170_cons', action: 'send_alert_170_cons'

  get 'cellnumbers/send_alert_182' => 'cellnumbers#send_alert_182', action: 'send_alert_182'

  get 'cellnumbers/send_alert_182_cons' => 'cellnumbers#send_alert_182_cons', action: 'send_alert_182_cons'

  get 'cellnumbers/send_alert_195' => 'cellnumbers#send_alert_195', action: 'send_alert_195'

  get 'cellnumbers/send_alert_195_cons' => 'cellnumbers#send_alert_195_cons', action: 'send_alert_195_cons'

  get 'cellnumbers/send_alert_220' => 'cellnumbers#send_alert_220', action: 'send_alert_220'

  get 'cellnumbers/send_alert_220_cons' => 'cellnumbers#send_alert_220_cons', action: 'send_alert_220_cons'

  get 'cellnumbers/send_alert_285' => 'cellnumbers#send_alert_285', action: 'send_alert_285'

  get 'cellnumbers/send_alert_285_cons' => 'cellnumbers#send_alert_285_cons', action: 'send_alert_285_cons'

  get 'cellnumbers/send_alert_all' => 'cellnumbers#send_alert_all', action: 'send_alert_all'

  get 'cellnumbers/send_alert_coaches' => 'cellnumbers/send_alert_coaches', action: 'send_alert_coaches'

   get 'cellnumbers/remove' => 'cellnumbers#remove'

  post 'create_user' => 'users#create', as: :create_user

  resources :seasons

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :users, except: :create

  resources :leagues do
    resources :schools, controller: "leagues/schools"
    resources :wrestlers, controller: "leagues/wrestlers"
      member do
        delete :delete_wrestler
      end
  end

  resources :schools do
    collection { get :autocomplete }
    resources :wrestlers, controller: "schools/wrestlers" do
      collection do
       post :import 
       get :help
       get :download
     end
    end
  end

  resources :cellnumbers, only: [:index, :show, :new, :create, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :alerts

  resources :comments

  resources :tournaments do
    collection { get :autocomplete }
  end

  resources :bouts

  resources :wrestlers do
    collection { get :autocomplete }
    resources :bouts, controller: "wrestlers/bouts" do
      collection { post :import }
    end
    collection do
      delete 'destroy_all'
    end
  end

    root 'welcome#index'

end
