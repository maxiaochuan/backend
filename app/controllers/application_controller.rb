class ApplicationController < ActionController::API

  attr_accessor :current_user

  before_action :authenticate_user!

  def authenticate_user!
    header = request.headers['Authorization'].presence
    token = header.split(' ').last if header

    database_authenticate_user! token
  end

  def database_authenticate_user! token
    payload = JWT.decode token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' } if token

  rescue JWT::VerificationError => e
    render json: { errors: e.message }, status: :unauthorized

    # if payload
    #   @current_user ||= User.find_by email
    # end
  end
end
