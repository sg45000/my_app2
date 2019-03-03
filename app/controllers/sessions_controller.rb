class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remenber_me] ? remenber(@user) : forget(@user) 
      flash[:success] = "you got logged in !"
      redirect_to @user
    else
      flash.now[:danger] = "Failed login. Retry now!"
      render 'new'
    end
  end
  
  def destroy
    logout if logged_in?
    redirect_to root_url
  end
  
end
