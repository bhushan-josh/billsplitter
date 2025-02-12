# frozen_string_literal: true

module V1
  module ExpenseService
    class Index < V1::Base
      attr_reader :active_user

      def initialize(active_user)
        super()
        @active_user = active_user
      end

      def call
        expenses = Expense.where(payer_id: active_user)
        message = I18n.t('expense.index')
        success_response(message, expenses)
      end
    end
  end
end
