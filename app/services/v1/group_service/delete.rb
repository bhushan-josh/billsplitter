# frozen_string_literal: true

module V1
  module GroupService
    class Delete < V1::Base
      attr_reader :params, :message

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: group.errors) unless delete_group

        success_response(message)
      end

      def delete_group
        @group = Group.find(delete_params[:id])
        unless @group.destroy
          @message = I18n.t('message.delete.failure', item: 'Group')
          return false
        end
        @message = I18n.t('message.delete.success', item: 'Group')
        true
      end

      def delete_params
        params.permit(:id)
      end
    end
  end
end
