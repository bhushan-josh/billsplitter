class GroupMember < ApplicationRecord
  # assosiations
  belong_to :group
  belong_to :user

  # validation
  validates :group, presence: true
  validates :user, presence: true

  enum role: { admin: "admin", member: "member" }
end
