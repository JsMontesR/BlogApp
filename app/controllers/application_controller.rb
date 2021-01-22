class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      begin
        @current_user ||= User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        @current_user = nil
      end
    else
      @current_user = nil
    end
  end
end
