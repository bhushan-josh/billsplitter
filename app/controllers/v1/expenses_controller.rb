# frozen_string_literal: true

module V1
  class ExpensesController < V1::BaseController
    def create
      result = V1::ExpenseService::Create.new(params).call
      handle_service_result(result)
    end

    def index
      result = V1::ExpenseService::Index.new(active_user).call
      handle_service_result(result)
    end

    def show
      result = V1::ExpenseService::Show.new(params).call
      handle_service_result(result)
    end

    def update
      result = V1::ExpenseService::Update.new(params).call
      handle_service_result(result)
    end

    def destroy
      result = V1::ExpenseService::Delete.new(params).call
      handle_service_result(result)
    end
  end
end
