# frozen_string_literal: true

class ExpenseSplit < ApplicationRecord
  # assosiations
  belongs_to :expense
  belongs_to :payee, class_name: 'User'

  # validation
  validates :expense, presence: true
  validates :payee, presence: true
  validates :amount, presence: true
  enum status: { pending: 'pending', settle: 'settle' }

  # player from expense should not be payee
end
