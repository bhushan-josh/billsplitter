class Expense < ApplicationRecord
  # assosiations
  belongs_to :payee, class_name: "User"
  belongs_to :expense_group, class_name: "Group"

  has_many :expensesplits

  # validation
  validates :payer, presence: true
  validates :expense_group, presence: true
  validates :amount, presence: true
end
