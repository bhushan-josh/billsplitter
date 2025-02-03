# frozen_string_literal: true

module V1
  module ExpenseService
    class Delete < V1::Base
      attr_reader :params, :message

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: expense.errors) unless delete_expense

        success_response(message)
      end

      def delete_expense
        @expense = Expense.find(delete_params[:id])
        if @expense.destroy
          @message = I18n.t('expense.delete.success')
          true
        else
          @message = I18n.t('expense.delete.failure')
          false
        end
      end

      def delete_params
        params.permit(:id)
      end
    end
  end
end
