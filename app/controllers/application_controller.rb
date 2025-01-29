class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Pundit::Authorization
  allow_browser versions: :modern
end
