class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  allow_browser versions: :modern
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to access this page."
  end
  
end
