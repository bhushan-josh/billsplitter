# frozen_string_literal: true

module V1
  module UserService
    class Update < V1::Base
      attr_reader :params, :user

      def initialize(params)
        @params = params
      end

      def call
        return failure_response(message, errors: user.errors) unless update_user

        success_response(message)
      end

      def update_user
        @user = User.find(update_params[:id])
        if @user.update(update_params.except(:id))
          @message = I18n.t('user.update.success')
          true
        else
          @message = I18n.t('user.update.failure')
          false
        end
      end

      def update_params
        params.permit(:id, :first_name, :last_name, :phone, :email, :password)
      end
    end
  end
end
