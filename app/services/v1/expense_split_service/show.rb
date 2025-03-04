# frozen_string_literal: true

module V1
  module ExpenseSplitService
    class Show < V1::Base
      attr_reader :params, :active_user

      def initialize(params, active_user)
        super()
        @params = params
        @active_user = active_user
      end

      def call
        return failure_response(@message, errors: errors) unless calculate_balance

        set_data
        success_response(@message, @data)
      end

      private

      def calculate_balance
        payee_id = permitted_params[:payee_id].to_i
        return false unless payee_id.positive?

        amount1 = ExpenseSplit.where(payer_id: @active_user.id, payee_id: payee_id, status: :pending).sum(:amount)
        amount2 = ExpenseSplit.where(payer_id: payee_id, payee_id: @active_user.id, status: :pending).sum(:amount)

        @balance = amount1 - amount2
        true
      end

      def set_data
        @data = @balance
        @message = I18n.t('message.show.details', item: 'Expense')
      end

      def permitted_params
        params.permit(:payee_id).merge(payee_id: params[:payee_id] || params[:id])
      end
    end
  end
end
