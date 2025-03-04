# frozen_string_literal: true

module V1
  module ExpenseSplitService
    class Index < V1::Base
      attr_reader :active_user

      def initialize(active_user)
        super()
        @active_user = active_user
      end

      def call
        expense_splits = ExpenseSplit.where(payer_id: active_user.id).or(ExpenseSplit.where(payee_id: active_user.id))
        message = I18n.t('message.index', item: 'Expense Split')
        success_response(message, expense_splits)
      end
    end
  end
end
