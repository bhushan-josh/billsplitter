# frozen_string_literal: true

module V1
  class SettlementsController < V1::BaseController
    def create
      result = V1::SettlementService::Create.new(params, active_user).call
      handle_service_result(result)
    end

    def index
      result = V1::SettlementService::Index.new(active_user).call
      handle_service_result(result)
    end

    def show
      result = V1::SettlementService::Show.new(params).call
      handle_service_result(result)
    end

    def destroy
      result = V1::SettlementService::Delete.new(params).call
      handle_service_result(result)
    end
  end
end
