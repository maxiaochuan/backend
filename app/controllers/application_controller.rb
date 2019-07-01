class ApplicationController < ActionController::API

  attr_accessor :current_user

  before_action :authenticate_user!

  def authenticate_user!
    header = request.headers['Authorization'].presence
    token = header.split(' ').last if header

    payload = JWT.decode token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' } if token

    if payload
      @current_user ||= User.find_by_email payload[0]['user']['email']
      headers['Authorization'] = "Bearer #{@current_user.jwt_token}"
    end

    raise JWT::VerificationError unless @current_user

  rescue JWT::ExpiredSignature => e
    render json: { status: 'EXPIRED_SIGNATURE', errors: e.message }, status: :unauthorized
  rescue JWT::VerificationError => e
    render json: { status: 'VERIFICATION_ERROR', message: e.message }, status: :unauthorized
  end
end
