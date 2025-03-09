# frozen_string_literal: true

class Settlement < ApplicationRecord
  # associations
  belongs_to :payer, class_name: 'User'
  belongs_to :payee, class_name: 'User'

  # validations
  validates :payer, presence: true
  validates :payee, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # custom validation to ensure payer and payee are different
  validate :payer_and_payee_must_be_different

  private

  def payer_and_payee_must_be_different
    errors.add(:payee, "can't be the same as payer") if payer == payee
  end
end
