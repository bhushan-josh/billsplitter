# frozen_string_literal: true

class GroupMember < ApplicationRecord
  # assosiations
  belongs_to :group
  belongs_to :user

  # validation
  validates :group, presence: true
  validates :user, presence: true

  enum role: { admin: 'admin', member: 'member' }
end
