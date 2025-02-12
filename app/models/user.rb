# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # associations
  has_many :groups
  has_many :group_members
  has_many :expenses
  has_many :expense_splits
  has_many :settlements

  # validation
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 10 }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: 'is invalid' }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :email, uniqueness: true
end
