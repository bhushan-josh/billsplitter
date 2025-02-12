# frozen_string_literal: true

class JwtService
  JWT_ALGORITHM = 'HS256'

  class << self
    def encode(payload = {})
      JWT.encode(
        payload,
        Rails.application.credentials.secret_key_base,
        JWT_ALGORITHM
      )
    end

    def decode(token)
      JWT.decode(
        token,
        Rails.application.credentials.secret_key_base,
        true,
        { algorithm: JWT_ALGORITHM }
      )
    end
  end
end
