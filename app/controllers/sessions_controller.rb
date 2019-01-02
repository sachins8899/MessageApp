class SessionsController < ApplicationController
  
  def login
    @user = User.new
  end
  
  def auth
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Wellcome, you have successfully loged in"
      redirect_to root_path
    else
      flash.now[:danger] ="Wrong Login Information !!"
      render 'login'
    end
  end
  
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ="Your Accout was successful created !"
      redirect_to signup_path
    else
      flash[:success] ="Sorry!! Try again after some time."
      redirect_to signup_path
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:username,:f_name,:l_name,:password)
  end
  
end