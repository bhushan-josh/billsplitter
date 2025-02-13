# frozen_string_literal: true

module V1
  module SettlementService
    class Delete < V1::Base
      attr_reader :params, :message

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: settlement.errors) unless delete_settlement

        success_response(message)
      end

      def delete_settlement
        @settlement = Settlement.find(delete_params[:id])
        unless @settlement.destroy
          @message = I18n.t('message.delete.failure', item: 'Settlement')
          return false
        end
        @message = I18n.t('message.delete.success', item: 'Settlement')
        true
      end

      def delete_params
        params.permit(:id)
      end
    end
  end
end
