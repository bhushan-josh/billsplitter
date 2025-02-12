# frozen_string_literal: true

module V1
  module ExpenseService
    class Show < V1::Base
      attr_reader :params, :expense

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message) unless validate_expense

        set_data
        success_response(message, data)
      end

      def validate_expense
        @expense = Expense.find(show_params[:id])
        return true if expense

        @message = I18n.t('expense.show.invalid')
        false
      end

      def set_data
        @data = V1::ExpenseSerializer.new(expense).serializable_hash
        @message = I18n.t('expense.show.details')
      end

      def show_params
        params.permit(:id)
      end
    end
  end
end
