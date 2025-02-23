# frozen_string_literal: true

module V1
  module UserService
    class Update < V1::Base
      attr_reader :params, :user

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message, errors: user.errors) unless update_user

        success_response(message)
      end

      def update_user
        @user = User.find(update_params[:id])
        unless @user.update(update_params.except(:id))
          @message = I18n.t('message.update.failure', item: 'User')
          return false
        end
        @message = I18n.t('message.update.success', item: 'User')
        true
      end

      def update_params
        params.permit(:id, :first_name, :last_name, :phone, :email, :password)
      end
    end
  end
end
