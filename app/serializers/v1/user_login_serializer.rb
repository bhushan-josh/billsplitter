# frozen_string_literal: true

module V1
  class UserLoginSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :phone, :email, :token, :full_name

    def token
      JwtService.encode({ id: object.id })
    rescue StandardError => e
      Rails.logger.error("JWT Encoding Failed: #{e.message}")
      'Invalid token'
    end

    def full_name
      "#{object.first_name} #{object.last_name}"
    end
  end
end
