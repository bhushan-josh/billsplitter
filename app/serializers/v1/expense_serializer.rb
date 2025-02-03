# frozen_string_literal: true

module V1
  class ExpenseSerializer < ActiveModel::Serializer
    attributes :payer_id, :group_id, :amount, :description

    has_many :expense_splits, serializer: V1::ExpenseSplitSerializer
  end
end
