class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :count_unarchived_articles

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

  # Helper method for getting current articles (non-archived) on the articles main-page
  def count_unarchived_articles
    Article.count_without_status(VisibleFeature::ARCHIVED)
  end
end
