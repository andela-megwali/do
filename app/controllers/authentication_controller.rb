class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    return invalid_credentials_detected unless authorize_user
    user_token = JsonWebToken.encode(user_id: authorize_user.id)
    # render json: { user_token: JsonWebToken.encode(user_id: authorize_user.id) }
    # if user_token
      render json: { auth_token: user_token }
    # else
    #   invalid_credentials_detected
    # end
  end

  def logout
    @current_user
  end




  private

  def authorize_user
    @user = User.find_by(email: params[:email])
    @user.authenticate(params[:password]) if @user
  end

  def invalid_credentials_detected
    render json: { error: "Invalid Credentials Detected" }, status: 401
  end
end



# def initialize(email, password)
#     @email = email
#     @password = password
#   end

#   def call
#     JsonWebToken.encode(user_id: user.id) if user
#   end

#   private

#   attr_accessor :email, :password

#   def user
#     user = User.find_by(email: email)
#     return user if user && user.authenticate(password)
#     errors.add :user_authentication, "Invalid Credentials"
#     nil
#   end