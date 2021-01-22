# Concern for verifying if an user is logged in, ideal before give response for a petition
module PrivateGuard
  def require_user
    current_user ? true : (redirect_to root_path, notice: 'You need to be logged in!, please log in for navigate')
  end
end
