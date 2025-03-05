# frozen_string_literal: true

module V1
  module ExpenseSplitService
    class Create < V1::Base
      attr_reader :params

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: errors) unless create_expense_split

        success_response(message, @expense_split)
      end

      private

      def create_expense_split
        @expense_split = ExpenseSplit.new(create_params)
        unless @expense_split.save
          @message = I18n.t('message.create.failure', item: 'Expense Split')
          return false
        end
        @message = I18n.t('message.create.success', item: 'Expense Split')
        true
      end

      def create_params
        params.permit(:payer_id, :payee_id, :amount).tap do |whitelisted|
          whitelisted[:expense_id] = params[:expense_id] if params.key?(:expense_id)
        end
      end
    end
  end
end
