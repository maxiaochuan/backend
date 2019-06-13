class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    p = params.require(:user).permit(:email, :phone, :password)

    @current_user ||= User.find_by email: p[:email]
    @current_user ||= User.find_by phone: p[:phone]

    puts @current_user.to_s

    render json: @current_user
  end
end
