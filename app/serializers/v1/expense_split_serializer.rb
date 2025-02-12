# frozen_string_literal: true

module V1
  class ExpenseSplitSerializer < ActiveModel::Serializer
    attributes :id, :payer_id, :payee_id, :amount, :status
  end
end
