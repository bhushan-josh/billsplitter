class Settlement < ApplicationRecord
  # assosiations
  belongs_to :payer, class_name: "User"
  belongs_to :payee, class_name: "User"

  # validation
  validates :payer, presence: true
  validates :payee, presence: true
  validates :amount, presence: true

  # find payer and payee diff validation
end
