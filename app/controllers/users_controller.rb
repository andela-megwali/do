class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, except: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: not_created_message }, status: 400
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { error: not_updated_message }, status: 400
    end
  end

  def destroy
    render json: { message: delete_message } if @user.destroy
  end

  private

  def set_user
    @user = @current_user
  end

  def user_params
    params.permit(:firstname, :lastname, :email, :password)
  end
end
