# frozen_string_literal: true

class Expense < ApplicationRecord
  # associations
  belongs_to :payer, class_name: 'User'
  belongs_to :group

  has_many :expense_splits, dependent: :destroy
  accepts_nested_attributes_for :expense_splits, allow_destroy: true

  # validation
  validates :payer, presence: true
  validates :group, presence: true
  validates :amount, presence: true
end
