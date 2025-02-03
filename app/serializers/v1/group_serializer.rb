# frozen_string_literal: true

module V1
  class GroupSerializer < ActiveModel::Serializer
    attributes :name, :creator_id, :description

    has_many :group_members, serializer: V1::GroupMemberSerializer
  end
end
