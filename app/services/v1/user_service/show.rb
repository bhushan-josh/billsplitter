# frozen_string_literal: true

module V1
  module UserService
    class Show < V1::Base
      attr_reader :params, :user

      def initialize(params)
        super()
        @params = params
      end

      def call
        return failure_response(message) unless validate_user

        set_data
        success_response(message, data)
      end

      def validate_user
        @user = User.find(show_params[:id])
        return true if user

        @message = I18n.t('user.show.invalid')
        false
      end

      def set_data
        @data = V1::UserLoginSerializer.new(user).serializable_hash
        @message = I18n.t('user.show.details')
      end

      def show_params
        params.permit(:id)
      end
    end
  end
end
