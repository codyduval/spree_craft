Rails.application.routes.draw do
  devise_for :user,
             :controllers => { :sessions => 'user_sessions',
                               :registrations => 'user_registrations',
                               :passwords => "user_passwords" },
             :skip => [:unlocks, :omniauth_callbacks],
             :path_names => { :sign_out => 'logout'}

  resources :users, :only => [:edit, :update]

  devise_scope :user do
    get "/login" => "user_sessions#new", :as => :login
    get "/signup" => "user_registrations#new", :as => :signup
  end


  get '/checkout/registration' => 'checkout#registration', :as => :checkout_registration
  put '/checkout/registration' => 'checkout#update_registration', :as => :update_checkout_registration

  get '/orders/:id/token/:token' => 'orders#show', :as => :token_order

  resource :session do
    member do
      get :nav_bar
    end
  end
  resource :account, :controller => "users"

end
