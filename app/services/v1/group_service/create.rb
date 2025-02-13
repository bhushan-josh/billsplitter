# frozen_string_literal: true

module V1
  module GroupService
    class Create < V1::Base
      attr_reader :params, :message

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: group.errors) unless create_group

        success_response(message, @group)
      end

      def create_group
        @group = Group.new(create_params)
        unless @group.save
          @message = I18n.t('message.create.failure', item: 'Group')
          return false
        end
        @message = I18n.t('message.create.success', item: 'Group')
        true
      end

      def create_params
        params.permit(:name, :creator_id, :description, group_members_attributes: %i[member_id role])
      end
    end
  end
end
