# frozen_string_literal: true

class GroupMember < ApplicationRecord
  # associations
  belongs_to :group
  belongs_to :member, class_name: 'User'

  # validations
  validates :member_id, uniqueness: { scope: :group_id }

  enum :role, { member: 0, admin: 1 }
end
