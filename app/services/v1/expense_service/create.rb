# frozen_string_literal: true

module V1
  module ExpenseService
    class Create < V1::Base
      attr_reader :params

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: expense.errors) unless create_expense

        success_response(message, @expense)
      end

      def create_expense
        @expense = Expense.new(create_params)
        unless @expense.save
          @message = I18n.t('message.create.failure', item: 'Expense')
          return false
        end
        @message = I18n.t('message.create.success', item: 'Expense')
        true
      end

      def create_params
        params.permit(:payer_id, :group_id, :amount, :description, expense_splits_attributes: %i[payer_id payee_id amount status])
      end
    end
  end
end
