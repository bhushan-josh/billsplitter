# frozen_string_literal: true

module V1
  module GroupService
    class Delete < V1::Base
      attr_reader :params, :message

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: group.errors) unless delete_group

        success_response(message)
      end

      def delete_group
        @group = Group.find(delete_params[:id])
        if @group.destroy
          @message = I18n.t('group.delete.success')
          true
        else
          @message = I18n.t('group.delete.failure')
          false
        end
      end

      def delete_params
        params.permit(:id)
      end
    end
  end
end
