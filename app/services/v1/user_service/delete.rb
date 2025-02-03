# frozen_string_literal: true

module V1
  module UserService
    class Delete < V1::Base
      attr_reader :params, :message

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: user.errors) unless delete_user

        success_response(message)
      end

      def delete_user
        @user = User.find(delete_params[:id])
        if @user.destroy
          @message = I18n.t('user.delete.success')
          true
        else
          @message = I18n.t('user.delete.failure')
          false
        end
      end

      def delete_params
        params.permit(:id)
      end
    end
  end
end
