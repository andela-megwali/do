class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    return invalid_credentials_detected unless authenticate_user
    payload = {
      user_id: authenticate_user.id,
      issue_number: authenticate_user.issue_number
    }
    user_token = JsonWebToken.encode(payload)
    render json: { auth_token: user_token, message: login_message }
  end

  def logout
    if @current_user.update(issue_number: rand(100..999).to_s)
      render json: { message: logout_message }
    end
  end

  private

  def login_params
    params[:email].downcase! if params[:email]
    params.permit(:email, :password)
  end

  def authenticate_user
    @user = User.find_by(email: login_params[:email])
    @user.authenticate(login_params[:password]) if @user
  end

  def invalid_credentials_detected
    render json: { error: invalid_login_message }, status: 401
  end
end
