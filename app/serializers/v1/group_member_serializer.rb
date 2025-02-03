# frozen_string_literal: true

module V1
  class GroupMemberSerializer < ActiveModel::Serializer
    attributes :id, :member_id, :role
  end
end
