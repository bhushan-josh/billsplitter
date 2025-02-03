# frozen_string_literal: true

module V1
  class UserLoginSerializer
    include FastJsonapi::ObjectSerializer

    attributes :first_name, :last_name, :phone, :email

    attribute :token do |object|
      JwtService.encode({ id: object.id })
    end

    attribute :full_name do |object|
      "#{object.first_name} #{object.last_name}"
    end
  end
end
