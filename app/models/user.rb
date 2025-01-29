# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # assosiations
  has_many :groups
  has_many :group_members
  has_many :expenses
  has_many :expense_splits
  has_many :settlements

  # validation
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})\z/, message: 'is invalid' }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: 'is invalid' }
  validates :password, format: { with: /\A^[([a-z]|[A-Z])0-9_-]{6,20}\z/, message: 'must contain at least six characters' }
end
