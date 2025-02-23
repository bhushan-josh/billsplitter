# frozen_string_literal: true

module V1
  module ExpenseService
    class Update < V1::Base
      attr_reader :params, :expense

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: expense.errors) unless update_expense

        success_response(message)
      end

      def update_expense
        @expense = Expense.find(update_params[:id])
        unless @expense.update(update_params.except(:id))
          @message = I18n.t('message.update.failure', item: 'Expense')
          return false
        end
        @message = I18n.t('message.update.success', item: 'Expense')
        true
      end

      def update_params
        params.permit(:id, :payer_id, :expense_id, :amount, :description, expense_splits_attributes: %i[payer_id payee_id amount status])
      end
    end
  end
end
