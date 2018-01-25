class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  def new
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end
  
  def edit
    @category = Category.find(params[:id])
    if current_user == @category.user || current_user.admin?
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "Cannot edit another user's category"
      redirect_to root_url
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to @category
    else
      flash[:danger] = "Invalid category name"
      redirect_to @category
    end
  end
  
  def index
    @user = current_user
    @categories = Category.all
  end
  
  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = "New category created: #{params[:category][:name]}"
      redirect_to categories_path
    else
      flash[:danger] = "Error creating new category: #{@category.errors.messages}"
      @categories = []
      redirect_to categories_path
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if current_user == @category.user || current_user.admin?
      @category.destroy
      flash[:success] = "Category deleted"
    else
      flash[:danger] = "Cannot delete other user's category"
    end
    redirect_to request.referrer || root_url
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
