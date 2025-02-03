# frozen_string_literal: true

class V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!
  before_action :authenticate!

  def handle_service_result(result)
    status = result[:success] ? :ok : :unprocessable_entity
    render json: result, status: status
  end

  private

  def authenticate!
    raise ActiveRecord::RecordNotFound unless active_user
  rescue ActiveRecord::RecordNotFound
    render json: { message: I18n.t('auth') }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { message: I18n.t('auth') }, status: :unauthorized
  rescue JWT::ExpiredSignature
    render json: { message: I18n.t('auth') }, status: :unauthorized
  end

  def active_user
    @active_user ||= User.find_by(id: jwt_payload['id'])
  end

  def jwt_payload
    JwtService.decode(request.headers['Authorization']).first
  end
end
