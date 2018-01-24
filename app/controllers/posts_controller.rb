class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  def new
    @user = current_user
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == current_user
      flash[:warning] = "You can only edit your own posts"
      redirect_to @post
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:content, :title)
  end
  
end
