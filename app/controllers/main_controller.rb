class MainController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def authenticate
    render json: {
      name: @current_user.name,
      phone: @current_user.phone,
    }
  end

  def set_authorization
    authorization = "Bearer #{@current_user.jwt_token}";
    headers['Authorization'] = authorization
    cookies[:Authorization] = authorization

    authorization
  end

  def login
    p = params.require(:user).permit(:email, :phone, :password)

    @current_user ||= User.find_by_email p[:email]
    @current_user ||= User.find_by_phone p[:phone]

    if @current_user
      if  @current_user.authenticate(p[:password])
        render json: {
          Authorization: set_authorization,
        }
      else
        message = 'password not match'
        render json: {
          password: [message],
        }, status: :unauthorized
      end
    else
      message = 'user doesn\'t exist'
      render json: {
        name: message,
      }, status: :unauthorized
    end
  end
end
