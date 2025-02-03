# frozen_string_literal: true

module V1
  module ExpenseService
    class Create < V1::Base
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: expense.errors) unless create_expense

        success_response(message)
      end

      def create_expense
        @expense = Expense.new(create_params)

        if @expense.save
          @message = I18n.t('expense.create.success')
          true
        else
          @message = I18n.t('expense.create.failure')
          false
        end
      end

      def create_params
        params.permit(:payer_id, :group_id, :amount, :description, expense_splits_attributes: %i[payer_id payee_id amount status])
      end
    end
  end
end
