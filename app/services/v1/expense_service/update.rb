# frozen_string_literal: true

module V1
  module ExpenseService
    class Update < V1::Base
      attr_reader :params, :expense

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: expense.errors) unless update_expense

        success_response(message)
      end

      def update_expense
        @expense = Expense.find(update_params[:id])
        if @expense.update(update_params.except(:id))
          @message = I18n.t('expense.update.success')
          true
        else
          @message = I18n.t('expense.update.failure')
          false
        end
      end

      def update_params
        params.permit(:id, :payer_id, :expense_id, :amount, :description)
      end
    end
  end
end
