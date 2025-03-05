# frozen_string_literal: true

module V1
  class ExpenseSplitsController < V1::BaseController
    def create
      result = V1::ExpenseSplitService::Create.new(params).call
      handle_service_result(result)
    end

    def index
      result = ExpenseSplitService::Index.new(active_user).call
      handle_service_result(result)
    end

    def show
      result = V1::ExpenseSplitService::Show.new(params, active_user).call
      handle_service_result(result)
    end

    def update
      result = V1::ExpenseSplitService::Update.new(params).call
      handle_service_result(result)
    end

    def destroy
      result = V1::ExpenseSplitService::Delete.new(params).call
      handle_service_result(result)
    end
  end
end
