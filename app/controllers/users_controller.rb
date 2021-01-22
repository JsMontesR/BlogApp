class UsersController < ApplicationController

  include Login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login # Concern calling for get logged in on signup
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
