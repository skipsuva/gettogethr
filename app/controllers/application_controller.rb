class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :authenticate!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate!
    redirect_to login_path, notice: "You must be logged in to do that." unless logged_in?
  end

  def is_interested?(gathering_id)
    gathering = Gathering.find(gathering_id)
    gathering.users.includes?(current_user)
  end

end
