class ApplicationController < ActionController::API
  include Concerns::Messages

  before_action :authenticate_request

  private

  def authenticate_request
    return token_not_authorized unless decode_auth_header.class.name == "User"
    @current_user = decode_auth_header
  end

  def token_not_authorized
    render json: { error: not_authorized_message }, status: 401
  end

  def decode_auth_header
    return nil unless request.headers["Authorization"].present?
    header_token = request.headers["Authorization"].split(" ").last
    decode_auth_token ||= JsonWebToken.decode(header_token)
    @user ||= User.find_by(id: decode_auth_token[:user_id]) if decode_auth_token
    @user if @user && (@user.issue_number == decode_auth_token[:issue_number])
  end
end
