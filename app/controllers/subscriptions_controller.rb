class SubscriptionsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy, :index]
  before_action :current_user,    only: [:create]
  
  def index
    @subscriptions = Subscription.where("user_id = ?", current_user)
  end
  
  def create
    @user = current_user
    @category = Category.find(params[:category_id])
    if @user.subscribe(@category)
      
      respond_to do |format|
        format.html { redirect_to @category }
        format.js
      end
    else
      flash[:danger] = "Unable to subscribe"
      redirect_to @category
    end
  end
  
  def destroy
    @user = current_user
    @subscription = Subscription.find(params[:id])
    @category = @subscription.category
    if @user.unsubscribe(@subscription)
      respond_to do |format|
        format.html { redirect_to @category }
        format.js
      end
      
    else
      flash[:danger] = "Unable to unsubscribe"
      redirect_to root_url
    end
  end
  
end
