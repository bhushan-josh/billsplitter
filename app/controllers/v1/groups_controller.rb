# frozen_string_literal: true

module V1
  class GroupsController < V1::BaseController
    def create
      result = V1::GroupService::Create.new(params).call
      handle_service_result(result)
    end

    def index
      result = V1::GroupService::Index.new(active_user).call
      handle_service_result(result)
    end

    def show
      result = V1::GroupService::Show.new(params).call
      handle_service_result(result)
    end

    def update
      result = V1::GroupService::Update.new(params).call
      handle_service_result(result)
    end

    def destroy
      result = V1::GroupService::Delete.new(params).call
      handle_service_result(result)
    end
  end
end
