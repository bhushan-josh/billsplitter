# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # assosiations
  has_many :groups, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :expense_splits, dependent: :destroy
  has_many :settlements, dependent: :destroy

  # validation
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})\z/, message: 'is invalid' }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: 'is invalid' }
end
