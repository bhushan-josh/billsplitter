# frozen_string_literal: true

module V1
  module GroupService
    class Index < V1::Base
      attr_reader :active_user

      def initialize(active_user)
        @active_user = active_user
      end

      def call
        groups = Group.joins(:group_members).where('group_members.member_id = ?', active_user)
        success_response(groups)
      end
    end
  end
end
