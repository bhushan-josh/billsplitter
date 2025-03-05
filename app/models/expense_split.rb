# frozen_string_literal: true

class ExpenseSplit < ApplicationRecord
  # assosiations
  belongs_to :payer, class_name: 'User'
  belongs_to :payee, class_name: 'User'

  # validation
  validates :payer, presence: true
  validates :payee, presence: true
  validates :amount, presence: true
  enum status: { pending: 0, settled: 1 }
end
