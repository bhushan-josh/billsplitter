class ApplicationController < ActionController::Base
  include Pundit::Authorization
  allow_browser versions: :modern
end
