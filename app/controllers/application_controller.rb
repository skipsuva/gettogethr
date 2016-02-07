class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?
  before_action :authenticate_user!

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def logged_in?
  #   !!current_user
  # end

  # def authenticate!
  #   redirect_to login_path, notice: "You must be logged in to do that." unless logged_in?
  # end

  def is_interested?(gathering_id)
    gathering = Gathering.find(gathering_id)
    gathering.users.include?(current_user)
  end

  def check_gathering_access(gathering_id)
    redirect_to gatherings_path, :flash => { :error => "You have not been invited to that gathering." } unless is_interested?(gathering_id)
  end

end
