# frozen_string_literal: true

module V1
  class UsersController < V1::BaseController
    def index
      result = V1::UserService::Index.new.call
      handle_service_result(result)
    end

    def show
      result = V1::UserService::Show.new(params).call
      handle_service_result(result)
    end

    def update
      result = V1::UserService::Update.new(params).call
      handle_service_result(result)
    end

    def destroy
      result = V1::UserService::Delete.new(params).call
      handle_service_result(result)
    end
  end
end
