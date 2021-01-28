class UsersController < ApplicationController

  include Login
  include PrivateGuard

  before_action :require_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login # Concern calling for getting logged in on signed-up
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "Your info have been updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :old_password, :password, :password_confirmation)
  end

end
