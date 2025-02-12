# frozen_string_literal: true

module V1
  class AuthController < V1::BaseController
    skip_before_action :authenticate!

    def login
      result = V1::AuthService::Login.new(params).call
      handle_service_result(result)
    end

    def signup
      result = V1::AuthService::Signup.new(params).call
      handle_service_result(result)
    end
  end
end
