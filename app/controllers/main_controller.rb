class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    p = params.require(:user).permit(:email, :phone, :password)

    @current_user ||= User.find_by_email p[:email]
    @current_user ||= User.find_by_phone p[:phone]

    if @current_user
      if  @current_user.authenticate(p[:password])
        headers['Authorization'] = "Bearer #{@current_user.jwt_token}"
        render json: {
          Authorization: headers['Authorization'],
        }
      else
        message = 'password not match'
        render json: {
          message: message,
        }, status: :unauthorized
      end
    else
      message = 'user doesn\'t exist'
      render json: {
        message: message,
      }, status: :unauthorized
    end
  end
end
