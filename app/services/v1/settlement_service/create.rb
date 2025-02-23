# frozen_string_literal: true

module V1
  module SettlementService
    class Create < V1::Base
      attr_reader :params, :active_user

      def initialize(params, active_user)
        super()
        @params = params
        @active_user = active_user
      end

      def call
        return failure_response(@message, errors: @settlement&.errors) unless create_settlement

        success_response(@message)
      end

      private

      def create_settlement
        calculate_balance
        return failure_response(I18n.t('settlement.create.other.no_balance', item: 'Settlement')) if @balance.zero?

        @settlement = Settlement.new(payer_id: @active_user.id, payee_id: create_params[:payee_id], amount: @balance)

        unless @settlement.save
          @message = I18n.t('message.create.failure', item: 'Settlement')
          return false
        end

        @message = I18n.t('message.create.success', item: 'Settlement')
        update_expense_splits
        true
      end

      def calculate_balance
        amount1 = ExpenseSplit.where(payer_id: @active_user.id, payee_id: create_params[:payee_id], status: :pending).sum(:amount)
        amount2 = ExpenseSplit.where(payer_id: create_params[:payee_id], payee_id: @active_user.id, status: :pending).sum(:amount)
        @balance = amount1 - amount2
      end

      def update_expense_splits
        ExpenseSplit.where(status: :pending, payer_id: @active_user.id, payee_id: create_params[:payee_id]).update_all(status: 1)
        ExpenseSplit.where(status: :pending, payer_id: create_params[:payee_id], payee_id: @active_user.id).update_all(status: 1)
      end

      def create_params
        params.require(:settlement).permit(:payee_id)
      end
    end
  end
end
