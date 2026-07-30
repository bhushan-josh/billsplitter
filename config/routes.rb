Rails.application.routes.draw do
  devise_for :users, controllers:{registrations:'users/registrations'}, skip: [:registrations, :sessions]

  api_version(
    :module => "V1",
    :header => {
      :name => "Accept",
      :value => "application/vnd.billsplitter.com; version=1"
    }
  ) do
    post "/login", to: "auth#login"
    post "/signup", to: "auth#signup"

    resources :users, only: [:index, :show, :create, :update, :destroy]
    resources :groups, only: [:index, :show, :create, :update, :destroy]
    resources :expenses, only: [:index, :show, :create, :update, :destroy]
  end
end
