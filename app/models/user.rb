class User < ApplicationRecord
  # assosiations
  has_many :groups
  has_many :group_members
  has_many :expenses
  has_many :expense_splits
  has_many :settlements

  # validation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Z0-9._+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i }
  validates :phone, presence: true, uniqueness: true, length: { minimum: 6 }
end
