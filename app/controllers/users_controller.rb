class UsersController < ApplicationController

  include Login
  include PrivateGuard
  include SecureTransaction

  before_action :require_user, except: %i[new create]

  def index
    @users = User.all
  end

  def show
    @user = find(User, params[:id]) # <--- Now this line instead of "@user = User.find(params[:id])"
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
    @user = find(User, params[:id])
  end

  def update
    if (@user = find(User, params[:user_id])).is_a?(User)
      if @user.update(user_params)
        redirect_to root_path, notice: 'Your info have been updated!'
      else
        render :edit
      end
    end
  end

  # Makes the logged user to follow the param user
  def add_follower
    if (@user = find(User, params[:user_id])).is_a?(User)
      current_user.follow(@user)
      redirect_to @user, notice: "Now you are following #{@user.username}!, and you can read his personal articles and comments!"
    end
  end

  # Makes the logged user to unfollow the param user
  def delete_follower
    if (@user = find(User, params[:user_id])).is_a?(User)
      current_user.unfollow(@user)
      redirect_to @user, notice: "You are not following #{@user.username} anymore!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :old_password, :password, :password_confirmation)
  end

end
