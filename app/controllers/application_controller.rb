class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  allow_browser versions: :modern
  before_action :authenticate_user!
end
