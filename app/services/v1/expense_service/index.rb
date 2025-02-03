# frozen_string_literal: true

module V1
  module ExpenseService
    class Index < V1::Base
      attr_reader :active_user

      def initialize(active_user)
        @active_user = active_user
      end

      def call
        expenses = Expense.where(payer_id: active_user)
        success_response(expenses)
      end
    end
  end
end
