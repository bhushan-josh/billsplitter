# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Associations
  has_many :groups, foreign_key: :creator_id, class_name: 'Group', dependent: :nullify
  has_many :group_members, foreign_key: :member_id, class_name: 'GroupMember', dependent: :destroy
  has_many :expenses, foreign_key: :payer_id, dependent: :destroy
  has_many :expense_splits_as_payer, class_name: 'ExpenseSplit', foreign_key: :payer_id, dependent: :nullify
  has_many :expense_splits_as_payee, class_name: 'ExpenseSplit', foreign_key: :payee_id, dependent: :nullify
  has_many :settlements_as_payer, class_name: 'Settlement', foreign_key: :payer_id, dependent: :nullify
  has_many :settlements_as_payee, class_name: 'Settlement', foreign_key: :payee_id, dependent: :nullify

  # Validations
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 10 }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: 'is invalid' }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum :role, { user: 0, admin: 1 }
end
