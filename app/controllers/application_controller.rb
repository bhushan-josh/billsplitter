class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :null_session
  allow_browser versions: :modern
  before_action :authenticate_user!
end
