class SessionsController < ApplicationController
  
  def login
    @user = User.new
  end
  
  def auth
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Wellcome, you have successfully loged in"
      redirect_to messages_path
    else
      if user
        flash[:error] =user.errors.full_messages
      else
        flash[:error] ="Please enter username and password"
      end
      redirect_to login_path
    end
  end
  
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ="Your Accout was successful created !"
      redirect_to login_path
    else
      flash[:error] =@user.errors.full_messages
      redirect_to signup_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] ="Logout Successfully !! "
    redirect_to root_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:username,:f_name,:l_name,:password)
  end
  
end