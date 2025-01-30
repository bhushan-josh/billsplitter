Rails.application.routes.draw do
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.billsplitter.com; version=1"}) do
    resources :users
    resources :groups

  end
  resources :users
  resources :groups

end
