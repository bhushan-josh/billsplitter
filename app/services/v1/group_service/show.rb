# frozen_string_literal: true

module V1
  module GroupService
    class Show < V1::Base
      attr_reader :params, :group

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message) unless validate_group

        set_data
        success_response(message, data)
      end

      def validate_group
        @group = Group.find(show_params[:id])
        return true if group

        @message = I18n.t('group.show.invalid')
        false
      end

      def set_data
        @data = V1::GroupSerializer.new(group).serializable_hash
        @message = I18n.t('group.show.details')
      end

      def show_params
        params.permit(:id)
      end
    end
  end
end
