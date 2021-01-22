class UsersController < ApplicationController

  include Login
  include PrivateGuard

  before_action :require_user, except: %i[new create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

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
      redirect_to root_path, notice: 'Your info have been updated!'
    else
      render :edit
    end
  end

  # Makes the logged user to follow the param user
  def add_follower
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to @user, notice: "Now you are following #{@user.username}!, and you can read his personal articles and comments!"
  end

  # Makes the logged user to unfollow the param user
  def delete_follower
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    redirect_to @user, notice: "You are not following #{@user.username} anymore!"
  end

  private

  def user_params
    params.require(:user).permit(:username, :old_password, :password, :password_confirmation)
  end

end
