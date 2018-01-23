class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account successfully created"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:info] = "You can only edit your profile"
      redirect_to root_url
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, 
                                :password, :password_confirmation)
  end
  
  def logged_in_user
    redirect_to login_path unless logged_in?
      
  end
  
end
