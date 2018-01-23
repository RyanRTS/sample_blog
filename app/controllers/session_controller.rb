class SessionController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Logged in"
      redirect_to root_url
    else
      flash[:danger] = "Wrong email/password"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = "User logged out"
    redirect_to root_url
  end

end