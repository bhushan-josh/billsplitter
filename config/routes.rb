Rails.application.routes.draw do
  devise_for :users, controllers:{registrations:'users/registrations'}
  
  api_version(
    :module => "V1",
    :header => {
      :name => "Accept",
      :value => "application/vnd.billsplitter.com; version=1"
    }
  ) do
    post "/login", to: "auth#login"
    post "/signup", to: "auth#signup"

    resources :users
    resources :groups
    resources :expenses
  end

  root to: "home#index"
  resources :users
end
