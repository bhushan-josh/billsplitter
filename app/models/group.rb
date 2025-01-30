# frozen_string_literal: true

class Group < ApplicationRecord
  # assosiations
  belongs_to :creator, class_name: 'User'

  has_many :members
  has_many :expenses

  # validation
  validates :group_name, presence: true, uniqueness: true
  validates :creator, presence: true
end
