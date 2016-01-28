class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: need strong param use here
    @user = User.find_by(email: params[:user][:email])
    # binding.pry
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You have been logged in"
    else
      @user = User.new
      flash.now[:notice] = "Bad Username or Password, idiot"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been logged out"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end