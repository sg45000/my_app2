class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = "you got logged in !"
      redirect_to @user
    else
      flash.now[:danger] = "Failed login. Retry now!"
      render 'new'
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
  
end
