class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, except: [:new, :create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: "User not created try again" }
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { error: "User not updated try again" }
    end
  end

  def show
    render json: @user
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted" }
  end

  private

  def set_user
    @user = @current_user
  end

  def user_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :email,
      :password
    )
  end
end
