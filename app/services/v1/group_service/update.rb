# frozen_string_literal: true

module V1
  module GroupService
    class Update < V1::Base
      attr_reader :params, :group

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: group.errors) unless update_group

        success_response(message)
      end

      def update_group
        @group = Group.find(update_params[:id])
        if @group.update(update_params.except(:id))
          @message = I18n.t('group.update.success')
          true
        else
          @message = I18n.t('group.update.failure')
          false
        end
      end

      def update_params
        params.permit(:id, :name, :creator_id, :description, group_members_attributes: %i[id member_id role _destroy])
      end
    end
  end
end
