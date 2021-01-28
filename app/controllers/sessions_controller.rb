class SessionsController < ApplicationController
  include Login

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) # Secure navigation for authenticate the user with the param password
      login # Concern calling for getting the session
    else
      # flash.now[:alert] = 'Email or password not valid'
      redirect_to login_path, notice: 'Username or password not valid'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
