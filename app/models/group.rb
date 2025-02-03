# frozen_string_literal: true

class Group < ApplicationRecord
  # associations
  belongs_to :creator, class_name: 'User'

  has_many :group_members, dependent: :destroy
  has_many :expenses, dependent: :destroy
  accepts_nested_attributes_for :group_members, allow_destroy: true

  # validation
  validates :name, presence: true, uniqueness: true
  validates :creator, presence: true
end
