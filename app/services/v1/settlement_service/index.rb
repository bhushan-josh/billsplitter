# frozen_string_literal: true

module V1
  module SettlementService
    class Index < V1::Base
      attr_reader :active_user

      def initialize(active_user)
        super()
        @active_user = active_user
      end

      def call
        settlements = Settlement.where(payer_id: active_user.id).or Settlement.where(payee_id: active_user.id)
        message = I18n.t('message.index', item: 'Settlement')
        success_response(message, settlements)
      end
    end
  end
end
