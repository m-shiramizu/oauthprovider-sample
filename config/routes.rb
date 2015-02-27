Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :loginstatuses
      get '/me' => "credentials#me"
    end
  end

  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "omniauth_callbacks"
  }

  mount Doorkeeper::Engine => '/oauth'
  root to: 'doorkeeper/applications#index'

  use_doorkeeper

end
