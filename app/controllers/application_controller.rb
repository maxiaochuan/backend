class ApplicationController < ActionController::API

  attr_accessor :current_user

  before_action :authenticate_user!

  def authenticate_user!
    header ||= request.headers['Authorition'].presence

    token = header && header.split(' ')[1];

    database_authenticate_user! token
  end

  def database_authenticate_user! token
    payload = token && JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })

    if payload
      @current_user ||= User.find_by email
    end
  end
end
