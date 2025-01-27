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
  validates :email, presence: true, uniqueness: true, format: { with: /\A([A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})\z/ }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/ }
end
