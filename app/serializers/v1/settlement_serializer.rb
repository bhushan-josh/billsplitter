# frozen_string_literal: true

module V1
  class SettlementSerializer < ActiveModel::Serializer
    attributes :id, :payer_id, :payee_id, :amount
  end
end
