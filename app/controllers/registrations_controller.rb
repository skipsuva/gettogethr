class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = 
    if @user.save
      session[:user_id] = @user.id
      @user.save
      redirect_to root_path, notice: "Thank you for signing up"
    else
      flash[:notice] = "You did something wrong, try again."
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
