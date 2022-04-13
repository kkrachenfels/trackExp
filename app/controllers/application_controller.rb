class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  before_action :authorized

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    if not logged_in?
      flash[:error] = "You need to be logged in to access this page."
      redirect_to '/welcome'
    end
  end

end
