class UsersController < ApplicationController
  before_action :logged_in_user? ,only:[:show,:edit,:update]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "こんにちは！#{@user.name}さん"
      log_in @user
      redirect_to user_url(@user)
    else
      render 'new'
      
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
  end
  
  private
  
  def logged_in_user?
    unless logged_in?
      flash[:danger] = "Please log in your account before access this page." 
      redirect_to login_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
end
