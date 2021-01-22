# Concern responsible for giving a session to an user
# and redirect to the main page if succeed
module Login

  extend ActiveSupport::Concern

  def login
    session[:user_id] = @user.id # Save user id in the session
    redirect_to root_url, notice: 'Logged in successfully!'
  end
end


