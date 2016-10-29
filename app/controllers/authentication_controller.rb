class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    return invalid_credentials_detected unless authorize_user
    user_token = JsonWebToken.encode(user_id: authorize_user.id)
    render json: { auth_token: user_token }
  end

  def logout
    @current_user
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def authorize_user
    @user = User.find_by(email: login_params[:email])
    @user.authenticate(login_params[:password]) if @user
  end

  def invalid_credentials_detected
    render json: { error: "Invalid Credentials Detected" }, status: 401
  end
end
