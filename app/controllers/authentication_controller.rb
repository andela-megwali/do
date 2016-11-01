class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    return invalid_credentials_detected unless authenticate_user
    payload = { user_id: authenticate_user.id, iss: authenticate_user.iss }
    user_token = JsonWebToken.encode(payload)
    render json: { auth_token: user_token }
  end

  def logout
    if @current_user.update(iss: rand(100..999).to_s)
      render json: { message: logout_message }
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def authenticate_user
    @user = User.find_by(email: login_params[:email])
    @user.authenticate(login_params[:password]) if @user
  end

  def invalid_credentials_detected
    render json: { error: invalid_login_message }, status: 401
  end
end
