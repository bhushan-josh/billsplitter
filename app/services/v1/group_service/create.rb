# frozen_string_literal: true

module V1
  module GroupService
    class Create < V1::Base
      attr_reader :params, :message

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: group.errors) unless create_group

        success_response(message)
      end

      def create_group
        @group = Group.new(create_params)

        if @group.save
          @message = I18n.t('group.create.success')
          true
        else
          @message = I18n.t('group.create.failure')
          false
        end
      end

      def create_params
        params.permit(:name, :creator_id, :description, group_members_attributes: %i[member_id role])
      end
    end
  end
end
