class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, except: [:create]

  def create
    @user = User.new(user_params)
    return not_created unless @user.save
    render json: @user
  end

  def update
    return not_updated unless @user.update(user_params)
    render json: @user
  end

  def destroy
    render json: { message: delete_message } if @user.destroy
  end

  private

  def set_user
    @user = @current_user
  end

  def user_params
    params[:email].downcase! if params[:email]
    params.permit(:firstname, :lastname, :email, :password)
  end
end
