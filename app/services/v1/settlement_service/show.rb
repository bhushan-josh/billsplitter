# frozen_string_literal: true

module V1
  module SettlementService
    class Show < V1::Base
      attr_reader :params, :settlement

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message) unless validate_settlement

        set_data
        success_response(message, data)
      end

      def validate_settlement
        @settlement = Settlement.find(show_params[:id])
        return true if settlement

        @message = I18n.t('message.show.invalid', item: 'Settlement')
        false
      end

      def set_data
        @data = V1::SettlementSerializer.new(settlement).serializable_hash
        @message = I18n.t('message.show.details', item: 'Settlement')
      end

      def show_params
        params.permit(:id)
      end
    end
  end
end
